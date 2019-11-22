# ePortfolio for Stephan Berry

## This will be a Git site that will showcase some work done over the years at Southern New Hampshire University

A list of my uploaded written code:

1. [slideshow.java](../master/SlideShowEnhancement.java)
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
