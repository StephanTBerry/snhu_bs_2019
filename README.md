# ePortfolio for Stephan Berry

## A little about me:
    The industry of Software Engineering has forever changed how we as humans do things, make things and envision our futures. Four years ago I entered into this world with minimal knowledge but with vast determination. This drive to expand my known horizons has given the opportunity to dive deep into this industry. The last three and a half years have helped me transcend into the next chapter of my career. All this hard work is going to help elevate my current role or open new and exciting roles for the future. 
    There are many aspects to the courses for the industry that we touch and elaborate on. One essential key to working in the industry is the ability to work or play well with others. Working with other team members be it local or remote, is essential to getting projects done. As a team you’re stronger and more diverse. You have the opportunity to grow and learn. As an example, in one of my classes: CS-250 Q6074 Software Development Lifecycle, part of the projects was to work with others in your class. You where give certain tasks to complete and work with your teammates to help them complete the project. You had to collaborate with each other to get it done. Which bring me into communicating with others within your team or stakeholders is another important aspect of the industry. We used methods to track work like Jira for an agile team method. This gives the stakeholders some insight as to the project and how it’s coming along.  Performed code reviews to learn how to improve oneself and also mentor other fellow software engineers. Working in database, I was able to further my skills by learning about databases that I have not used. This also applies to the data structure of the database which is very important. In particular I am very familiar with PostgreSQL. Within this Rational database management system (RDMS), you have to consider the data you are going to store, how it will be retrieved and what CRUD operations are going to be used against what and how often. Designing a good structure to ensure growth and flexibility will help it go far. This is not a trivial thing and usually takes someone from an architect stature to do well, but having some idea and knowing the right questions up front help. 
    The use of software lifecycle had made me better at software engineering. It has helped me become more efficient in my code writing. For the artifacts selected they showcase the three layers of software. There is the base layer, database, perhaps my strongest area, and where I take an existing database built for MySQL and transform it to work with PostgreSQL. The middle layer I use Java to not only implement a light framework but show that it is a powerful and versatile tool. This is a layer that I still work in and learn new things. For the top layer or the user interface, I have chosen to show some API work with Python. Python is one of my stronger languages and where I started my journey. This is also a very popular language and used widely. This shows who you can use an API call to a middle layer, execute some code then return values. HTML5 is the standard now and I am sure that will change over the next few months as there are advancements happening all the time. With that, I am well suited to adapt to those changes and excel. 
    With these advancements comes security concern. In the code written, it is important we lock down who gets access and how. The API calls should not be allowed to be called independently of the running program. Important information should be encrypted and sent over a secure channel like TLS or SSH. During my class: IT-380 T3131 Cybersecurity & Info Assurance, we learned about the different types of attacks and how to employ some basic strategy to defend or at least help in the defense against them. One thing in that entire course that stood out was education. One of the biggest downfalls of company security is not educating the employees about clickbait and emails where someone clicks a link and downloads a Trojan, worm or worse, Ransomware. If you can setup a strong Firewall, SonicWALL and a secured VPN, you have blocked some of these but your employees have to be aware as well.


## This will be a Git site that will showcase some work done over the years at Southern New Hampshire University

A list of my uploaded written code:

1. [slideshow.java](../snhu_bs_2019/SlideShowEnhancement.java)
    - This shows some basic framework in Java and some lightweight tools. 
    - Example of some of the code from that:
        - ```java
          private String getResizeIcon(int i) {
          String image = "<html><body><img width= '800' height='500' src='/resources/%s'</body></html>"; 
          images.forEach(name -> {
            if (name.indexOf(String.valueOf(i)) != -1) {
              return String.format(image,name);
            }
          })
         ```
