library(shiny)


shinyUI(
  fluidPage(
    titlePanel("Hierarchical Clustering Dendograms"),
    sidebarLayout(
      sidebarPanel(
        h3("Explanation"),
        p("This simple app provides an overview of different types of dendograms, 
          which could be used to help to visualize the results of Hierarchical Clustering Algorithm.\n"),
        strong("Dataset: mtcars"),
        br(),
        p("The code to generate plots was taken from ",a("Rpubs", href = "http://rpubs.com/gaston/dendrograms")),
        selectInput("select", label = h3("Select Plot"), 
                    choices = list("Original", "Leveled Labels",
                                   "Fancy Plot",
                                   "Triangular Plot", "Triangular Plot Colored",
                                   "Phylogenetic tree basic", "Cladogram",
                                   "Unrooted","Fan", "Colored Fan",
                                   "Radial"), selected = "Orignal")
      ),

      mainPanel(plotOutput("plot"))
    )
  
  )
  
)