#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ISLR)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    model <- lm(wage ~ age, data = Wage)
    
    modelPred <- reactive({
        ageInput <- input$sliderAge
        predict(model, newdata = data.frame(age = ageInput))
    })
    
    dataMean <- reactive({
        ageInput <- input$sliderAge
        mean(subset(Wage, age == ageInput)$wage)
    })

    output$plot <- renderPlot({
        ageInput <- input$sliderAge
        
        plot(Wage$age, Wage$wage, xlab = "Age", ylab = "Wage",
             bty = "n", pch = 4,
             xlim = c(15,85), ylim = c(10, 350))
        
        if(input$showModel) {
            #easy to use abline to plot the line
            abline(model, col = "blue", lwd = 2)
        }
        
        legend(65, 350, c("Model Prediction", "Mean in Data"), pch = 16, 
               col = c("blue", "red"), bty = "o", cex = 0.8)
        
        points(ageInput, modelPred(), col = "blue", pch = 16, cex = 2)
        points(ageInput, dataMean(), col = "red", pch = 16, cex = 2)
    })
    
    output$pred <- renderText({
        modelPred()
    })
    output$mean <- renderText({
        dataMean()
    })
})
