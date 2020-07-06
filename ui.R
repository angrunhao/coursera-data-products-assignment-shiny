#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Wage vs. Age"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h5("This application uses the ISLR Wage dataset and attempts to express wage as a
               function of age using simple linear regression."),
            h5("Use the slider to see how the
               predicted value differs from the underlying average value at each age."),
            br(),
            h6("Notice how the prediction falls off towards the older ages because the regression line
               takes in too much information in the younger ages, but
               does not take into account the drop off in wage in the older ages"),
            br(),
            sliderInput("sliderAge", "Slide to an Age, and hit submit!",
                        min = 18, max = 80, value = 20),
            checkboxInput("showModel", "Show/Hide Model", value = TRUE),
            submitButton("Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot"),
            h3("Predicted wage from model:"),
            textOutput("pred"),
            h3("Mean from the underlying data:"),
            textOutput("mean")
        )
    )
))
