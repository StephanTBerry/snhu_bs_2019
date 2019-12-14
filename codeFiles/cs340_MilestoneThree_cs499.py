#!/usr/bin/python
#
import json
from bson import json_util
import bottle
import datetime
from bottle import route,run,request,abort
import pymongo
from pymongo import MongoClient
import pprint
import random

connection = MongClient()
if connection : # Test initialization of client
  connection = MongoClient('localhost',27017) # this Mongo Instance is located via on same the machine. This could be changed to an actual IP if setup elsewhere.
  if connection : # Test to be sure connection is made to the specified client
    db = connection['market'] # This connection to the db on the NoSQL is specific to this UI and API calls
    if db.command("serverStatus") is not None: # Test to make sure db connection is made
      collection = db['stocks'] # This points to a specific collection within the specific db for this set of API calls
    else:
      abort(400, str("No connection can be made to the database"))
  else:
    abort(400, str("No connection to the collection was made"))
else:
  abort(400, str("No client connection is made. Ensure database is running"))

# Global def 
request = request.body.read().decode('utf8') # Incoming request of the body of data being sent via API

#setup URI paths for REST service
  
@route('/readBetween', method='GET')
#To grab certain data between a high and low value. Passed in parameters should be high and low.
def getBetween():
  try:
    body = request # Call to the def global variable to get incoming data.
    get_dict = json.loads(body)
    if body:
      low = get_dict.get('low','')
      high = get_dict.get('high','')
      if high is not None and low is not None and low > 0:
        result = collection.find({"50-Day Simple Moving Average":{"$gte":get_dict.get("low"),"$lt":get_dict.get("high")}}).count()
      else:
        abort(400,str("Need at least high or low value greater than zero."))
    if result:
      string = str(result)
    else:
      abort(404, 'Not Found')
  except pymongo.errors.OperationFailure as oe:
    abort(400, str(oe))
  return json.loads(json.dumps(string, indent=4, default=json_util.default))

@route('/readIndustry', method='GET')
#Create a list of tickers and return that per given parameter
def getOne():
  results = {}
  try:
    body = request # Call to the def global variable to get incoming data.
    if body:
      get_dict = json.loads(body)
      industry = str(get_dict.get('Industry'))
      result = collection.find({"Industry":industry})
      if result:
        for r in result:
          results.update({"Industry":str(r["Industry"]),"Ticker":str(r["Ticker"])})
      else:
        abort(404, 'Not Found')
    else:
      abort(404, 'No parameters passed in')
    string = str(results)
  except pymongo.errors.OperationFailure as oe:
    abort(400, str(oe))
  return json.loads(json.dumps(string, indent=4, default=json_util.default))

@route('/readSector', method='GET')
#Takes a sector and returns a grouped by industry for outstanding shares.
def getShares():
  results = []
  try:
    body = request # Call to the def global variable to get incoming data.
    if body:
      get_dict = json.loads(body)
      sector = str(get_dict.get('Sector'))
      agr = [{"$match":{"Sector":sector}},{"$group":{"_id":"$Industry","shares":{"$sum":"$Shares Outstanding"}}}]
      result = list(collection.aggregate(agr))
      if result:
        for r in result:
          results.append({"Industry":str(r["_id"]),"SharesTotal":r["shares"]})
      else:
        abort(404,'Not Found')
    else:
      abort(400, 'No parameters passed in')
    string = str(results)
  except pymongo.errors.OperationFailure as oe:
    abort(400, str(oe))
  return json.loads(json.dumps(string, indent=4, default=json_util.default))

@route('/create', method='POST')
# Create a record with passed in info.
def insert_document():
  document = {}
  try:
    body = request # Call to the def global variable to get incoming data.
    if body:
      get_dict = json.loads(body)
      # This should handle different sets of parameters. Dynamic set.
      for key in get_dict:
        document.update({str(key):str(get_dict.get(key,''))})
    else:
      abort(400, "No body to the Create POST")
    result = collection.insert_one(document)
    if result:
      string = "{result: INSERTED}"
    else:
      string = "{result: FAILURE}"
  except pymongo.errors.OperationFailure as ve:
    abort(400, str(ve))
  return json.loads(json.dumps(string, indent=4, default=json_util.default))

@route('/update', method='PUT')
#specific update statement to update volume given the ticker.
def updateOne():
  try:
    body = request # Call to the def global variable to get incoming data. 
    get_dict = json.loads(body)
    ticker = get_dict.get('Ticker')
    data = get_dict.get('Volume')
    if data < 0 or data is None:
      data = random.randrange(100)
    collection.update_one({"Ticker":ticker},{"$set":{"Volume":data}})
    result = collection.find_one({"Ticker":ticker})
    string = str(result)
  except pymongo.errors.OperationFailure as oe:
    abort(400, str(ve))
  return json.loads(json.dumps(string, indent=4, default=json_util.default))

@route('/delete', method='DELETE')
#specific delete statement to delete by the ticker id.
def delete_One():
  try:
    body = request # Call to the def global variable to get incoming data.
    if body:
      get_dict = json.loads(body)
      ticker = get_dict.get('Ticker')
      query = {"Ticker":str(ticker)}
      result = collection.delete_one(query)
      string = '{"\"result\": "' + str(result) + '}'
  except pymongo.errors.OperationFailure as oe:
    abort(400, str(ve))
  return json.loads(json.dumps(string, indent=4, default=json_util.default))

if __name__=='__main__':
  #app.run(debug=True)
  run(host='localhost', port=8080, debug=True)