
library(shiny)

shinyUI(
  fluidPage(
    # Application title
    titlePanel("Grade Calculator and Progress Report (2014 Fall)"),
    # Sidebar with data inputs
    sidebarLayout(
      sidebarPanel(
        h3("Please provide your grades"),
        # By using <fluidRow>, one can add columns
        fluidRow(
          column(3, 
                 h4("Quizzes", align="center"),   
                 numericInput("quiz1", "Quiz 1:", value='', min=0, max=15, step=0.5),
                 numericInput("quiz2", "Quiz 2:", '', min=0, max=15, step=0.5),
                 numericInput("quiz3", "Quiz 3:", '', min=0, max=15, step=0.5),
                 numericInput("quiz4", "Quiz 4:", '', min=0, max=15, step=0.5),
                 numericInput("quiz5", "Quiz 5:", '', min=0, max=15, step=0.5),
                 numericInput("quiz6", "Quiz 6:", '', min=0, max=15, step=0.5),
                 numericInput("quiz7", "Quiz 7:", '', min=0, max=15, step=0.5),
                 numericInput("quiz8", "Quiz 8:", '', min=0, max=15, step=0.5)
          ),
          column(1),
          column(3,
                 h4("HWs", align="center"),
                 numericInput("hw1", "HW 1:", '', min=0, max=25, step=0.5),
                 numericInput("hw2", "HW 2:", '', min=0, max=25, step=0.5),
                 numericInput("hw3", "HW 3:", '', min=0, max=25, step=0.5),
                 numericInput("hw4", "HW 4:", '', min=0, max=25, step=0.5),
                 numericInput("hw5", "HW 5:", '', min=0, max=25, step=0.5)
          ),
          column(1),
          column(3,
                 h4("Exams", align="center"),
                 numericInput("exam1", "Exam 1:", '', min=0, max=100, step=0.5),
                 numericInput("exam2", "Exam 2:", '', min=0, max=100, step=0.5),
                 numericInput("final", "Final:", '', min=0, max=120, step=0.5),
                 br(),
                 br(),
                 h4("Participation", align="center"),
                 numericInput("cp", "Participation:", '', min=0, max=15, step=0.5)
          )
        ), # END fluidRow
        #submitButton("Submit")
        fluidRow(
          column(2, actionButton("submitButton", "Submit")),
          column(2),
          column(2, actionButton("clearButton", "Clear"))
        )
        
      ), # END sidebarPanel
      # Show the results
      mainPanel(
        h3("Your progress report"),
        textOutput("totalEarned_text"),
        HTML("<br/>"),
        p("The following plots show your progress for each assignment (dashed line) and overall performance (solid line), before and after dropping the lowest quiz grade."),
        HTML("<br/>"),
        h4("Percentages before Adjustment", align="center"),
        plotOutput("gradePlot"),
        h4("Percentages after Adjustment (Retrospectively)", align="center"),
        plotOutput("gradePlot_adj")
      )       
    )
  )    
)