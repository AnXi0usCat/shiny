#install.packages("ape")
library(ape)
library(shiny)


shinyServer(function(input, output){
  
   hc = hclust(dist(mtcars))
   hcd = as.dendrogram(hc)
   
   output$plot <- renderPlot({
     
     if(input$select == "Original"){
       
       # very simple dendrogram
       par(bg = "white")
       plot(hc)
                          
      }else if(input$select == "Leveled Labels"){
       
       par(bg = "white")
       plot(hc, hang = -1)
       
      }else if(input$select == "Fancy Plot"){
        
        # fancy plot
        op = par(bg = "#DDE3CA")
        plot(hc, col = "#487AA1", col.main = "#45ADA8", col.lab = "#7C8071", 
             col.axis = "#F38630", lwd = 3, lty = 3, sub = "", hang = -1, axes = FALSE)
        # add axis
        axis(side = 2, at = seq(0, 400, 100), col = "#F38630", labels = FALSE, 
             lwd = 2)
        # add text in margin
        mtext(seq(0, 400, 100), side = 2, at = seq(0, 400, 100), line = 1, 
              col = "#A38630", las = 2)
  
      }else if(input$select == "Triangular Plot"){
        
        par(bg = "white")
        # alternative way to get a dendrogram
        plot(hcd, type = "triangle")
        
      }else if(input$select == "Triangular Plot Colored"){
        
        par(bg = "white")
        labelColors = c("#CDB380", "#036564", "#EB6841", "#EDC951")
        # cut dendrogram in 4 clusters
        clusMember = cutree(hc, 4)
        # function to get color labels
        colLab <- function(n) {
          if (is.leaf(n)) {
            a <- attributes(n)
            labCol <- labelColors[clusMember[which(names(clusMember) == a$label)]]
            attr(n, "nodePar") <- c(a$nodePar, lab.col = labCol)
          }
          n
        }
        
        # using dendrapply
        clusDendro = dendrapply(hcd, colLab)
        # make plot
        plot(clusDendro, main = "Cool Dendrogram", type = "triangle")
        
      }else if(input$select == "Phylogenetic tree basic"){
        
        # plot basic tree
        par(bg = "white")
        plot(as.phylo(hc), cex = 0.9, label.offset = 1)
        
      }else if(input$select == "Cladogram"){
        
        par(bg = "white")
        plot(as.phylo(hc), type = "cladogram", cex = 0.9, label.offset = 1)
        
      }else if(input$select == "Unrooted"){
        
        par(bg = "white")
        plot(as.phylo(hc), type = "unrooted")
        
      }else if(input$select == "Fan"){
        
        par(bg = "white")
        plot(as.phylo(hc), type = "fan")
        
      }else if(input$select == "Colored Fan"){
        
        par(bg = "white")
        plot(as.phylo(hc), type = "fan", tip.color = hsv(runif(15, 0.65, 
          0.95), 1, 1, 0.7), edge.color = hsv(runif(10, 0.65, 0.75), 1, 1, 0.7), edge.width = runif(20, 
          0.5, 3), use.edge.length = TRUE, col = "gray80")
        
      }else if(input$select == "Radial"){
        
        par(bg = "white")
        plot(as.phylo(hc), type = "radial")
        
      }
    })

})