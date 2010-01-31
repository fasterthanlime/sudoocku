import Matrix, Node, Path
import os/Time

Solver: class {
    
    root : Node
    path : Path
    
    generations := 3
    breadth := 100000
    risk := 15
    
    init: func(matrix: Matrix) {
        root = Node new(matrix)
        path = Path new()
        path push(root)
    }
    
    run: func {
        srand(Time microsec())
        
        //while(true) {
        for(i in 0..generations) {
            parent := path peek()
            
            maxScore := -99999999
            bestBreed : Node = null
            
            //for(i in 0..breadth) {
            while(maxScore < 0) {
                node := parent clone()
                
                node makeHoles(2)
                while(node randomize()) { /*printf(".")*/ }
                
                score := node score()
                if(score > maxScore) {
                    maxScore = score
                    bestBreed = node
                    
                    printf("\nFor now, best breed (score %d) = \n", maxScore)
                    bestBreed print()
                    parent = bestBreed
                } else {
                    //printf("%d", score)
                }
            }
        }
    }
    
}
