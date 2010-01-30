import Matrix, Node, Path

Solver: class {
    
    root : Node
    path : Path
    
    generations := 3
    breadth := 5
    risk := 15
    
    init: func(matrix: Matrix) {
        root = Node new(matrix)
        path = Path new()
        path push(root)
    }
    
    run: func {
        //while(true) {
        for(i in 0..generations) {
            parent := path peek()
            
            for(i in 0..breadth) {
                node := parent clone()
                for(i in 0..risk) {
                    could := node randomize()
                    if(!could) {
                        "Couldn't randomize!, mat = " println()
                        node print()
                        exit(1)
                    }
                }
                printf("After randomization, mat = \n")
                node print()
                parent add(node)
            }
        }
    }
    
}
