library(R6)
library(rlist)
source("Cell.R")
source("Stack.R")



MazeGenerator <- R6Class("MazeGenerator", 
    private = list(
      height = NA,
      width = NA,
      grid = list(),
      # create a grid of cells 
      createGrid = function(){
        for (col in 1:private$width) {
          for (row in 1:private$height) {
            cell = Cell$new(row,col)
            private$grid  = list.append(private$grid , cell)
          }
        }
      },
      
      # from 2-dim to 1-dim indexing
      getIndex = function(x,y){
        return(x + y*private$width - private$width)
      },
      
      # check neighbour cells 
      checkNeighbours = function(cell){
        stopifnot(Cell$classname == class(cell)[1]) 
        
        x = cell$x
        y = cell$y
        
        nextOptions = list() # list of unvisted neighbours 
        nextPos = list() # list of tuple if current or next position
        if(y<private$height){
          top = private$grid[[private$getIndex(x,y+1)]]
          if(top$visited==F){ # if top not visited
            nextOptions = list.append(nextOptions,top) # add to nextOptions
            nextPos     = list.append(nextPos,list(curt="top",nxt="bot")) # add to nextPos
          }
        }
        if(y>1){
          bot = private$grid[[private$getIndex(x,y-1)]]
          if(bot$visited==F){ # if bot not visited
            nextOptions = list.append(nextOptions,bot) # add to nextOptions
            nextPos     = list.append(nextPos,list(curt="bot",nxt="top")) # add to nextPos
          }
        }
        if(x>1){
          left = private$grid[[private$getIndex(x-1,y)]]
          if(left$visited==F){ # if left not visited
            nextOptions = list.append(nextOptions,left) # add to nextOptions
            nextPos     = list.append(nextPos,list(curt="left",nxt="right")) # add to nextPos
          }
          
        }
        if(x<private$width){
          right = private$grid[[private$getIndex(x+1,y)]]
          if(right$visited==F){ # if right not visited
            nextOptions = list.append(nextOptions,right) # add to nextOptions
            nextPos     = list.append(nextPos,list(curt="right",nxt="left")) # add to nextPos
          }
        }
        
        if(length(nextOptions)>0){
          nextInd  = sample(1:length(nextOptions),size=1) # select a random index from nextOptions
          nextCell = nextOptions[[nextInd]] # use the index to select a random next cell 
          nextPos  = nextPos[[nextInd]] # get position of the next cell 
          cell$removeWall(nextPos$curt) # remove wall from current to next cell
          nextCell$removeWall(nextPos$nxt) # remove wall from next to current cell
          return(nextCell)
        }else{
          return(NULL)
        }
      }
    ),
    public = list(
      
      # constructor
      initialize = function(height, width){
        
        stopifnot(is.numeric(height),is.numeric(width) )
        private$height = height
        private$width  = width
        
        # add grid
        private$createGrid()
        
      },
      
      
      draw = function(){
        # create canvas
        par(mar = c(.1, .1, .1, .1), xpd=TRUE)
        plot(NULL, xlim  = c(0,private$width+1), ylim = c(0, private$width+1), asp = 1, axes =F,ann =F)
        
        # draw cells
        for (cell in private$grid) {
          cell$show()
        }
        
      }, 
      
      createMaze = function(){
        toVisit = Stack$new() # stack of cells to visit
        current = private$grid[[1]] # set current cell to the first cell. 
        current$setVisited() # set cell as visited
        toVisit$push(current) # push the cell to stack of cells to explore
        while (!is.null(current) && length(toVisit$stack)>0) {
          
          current = private$checkNeighbours(current) # set current to a non-visited neighbor cell
          
          if(!is.null(current)){ # if current is not null we visit the cell (has unvisted neighbour cells)
            current$setVisited() # set cell as visited
            toVisit$push(current) # push to stack
          }else{ # else we backtrack until we find a cell that has a unvisted neighbour cell 
            current = toVisit$pop() #           
          }
          
        }
      }
      
      
      
    
    
  )
)


