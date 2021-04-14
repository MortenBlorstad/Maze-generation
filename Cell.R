

Cell <- R6Class("Cell",
                list(
                  x = NULL,
                  y = NULL,
                  x0 = NULL,
                  x1 = NULL,
                  y0 = NULL,
                  y1 = NULL,
                  size = 1,
                  visited = F,
                  topWall = T,
                  botWall = T,
                  leftWall = T,
                  rightWall = T,
                  color = NULL,
                  initialize = function(x, y){
                    self$x = x
                    self$y = y
                    self$x0 = x-self$size/2
                    self$x1 = x+self$size/2
                    self$y0 = y-self$size/2
                    self$y1 = y+self$size/2
                    self$visited = F
                    self$topWall = T
                    self$botWall = T
                    self$leftWall = T
                    self$rightWall = T
                    self$color = rgb(0.8,0.8,1)
                  },
                  setVisited = function(){self$visited = T},
                  removeWall = function(wall){
                    if(wall =="top") self$topWall = F
                    if(wall =="bot") self$botWall = F
                    if(wall =="left") self$leftWall = F
                    if(wall =="right") self$rightWall = F
                  },
                  show = function(){
                    if(self$visited == T)   rect(self$x0, self$y0, self$x1, self$y1,col = self$color, border = NA)
                    
                    if(self$botWall == T){
                      segments(self$x0,self$y0 ,self$x1, self$y0)
                    }else{
                      segments(self$x0,self$y0 ,self$x1, self$y0, col = "white") 
                      segments(self$x0,self$y0 ,self$x1, self$y0, col = self$color) 
                    }   
                    if(self$topWall == T){
                      segments(self$x0,self$y1 ,self$x1, self$y1)
                    }else{
                      segments(self$x0,self$y1 ,self$x1, self$y1,col = "white")
                      segments(self$x0,self$y1 ,self$x1, self$y1,col = self$color)
                    }
                    if(self$leftWall == T){
                      segments(self$x0,self$y0 ,self$x0, self$y1)
                    }else{
                      segments(self$x0,self$y0 ,self$x0, self$y1,col = "white")
                      segments(self$x0,self$y0 ,self$x0, self$y1,col = self$color)
                    }
                    if(self$rightWall == T){
                      segments(self$x1,self$y0 ,self$x1, self$y1)
                    }else{
                      segments(self$x1,self$y0 ,self$x1, self$y1,col = "white")
                      segments(self$x1,self$y0 ,self$x1, self$y1,col = self$color)
                    }
                    
                    
                  } 
                )
)