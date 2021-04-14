library(R6)
Stack <- R6Class("stack",
                 list(
                   stack = NULL,
                   initialize = function(){
                     self$stack = list()
                   },
                   pop = function(){
                     if(length(self$stack)<1){
                       return(NULL)
                     }else{
                       value = self$stack[[length(self$stack)]]
                       self$stack[[length(self$stack)]] = NULL
                       return(value) 
                     }
                   },
                   push = function(value){
                     self$stack = append(self$stack,value, length(self$stack))
                   }
                 ) 
)