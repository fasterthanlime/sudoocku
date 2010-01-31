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
        
        parent := path peek()
        counter := 0
        
        while(true) {
        //for(i in 0..generations) {
            
            maxScore := -9999999
            bestBreed : Node = null
            
            counter = 0
            
            //for(i in 0..breadth) {
            while(maxScore < 0) {
                node := parent clone()
                
                node makeHoles(-node score() / 4, root matrix)
                node randomize()
                //while(node randomize()) {}
                
                score := node score()
                if(score > maxScore) {
                    maxScore = score
                    bestBreed = node
                    parent = bestBreed
                    counter = 0
                    
                    printf("\nFor now, best breed (score %d) = \n", maxScore)
                    bestBreed print()
                } else {
                    //printf("Breeding... score = %d, counter = %d\n", score, counter)
                    counter += 1
                    if(counter >= 10000) {
                        counter = 0
                        node swapRandomly(81, root matrix)
                        printf("Shaking... matrix = \n")
                        node print()
                    }
                }
                
            }
        }
    }
    
}
