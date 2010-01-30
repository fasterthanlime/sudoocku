import Matrix, Node, Path

Solver: class {
    
    root : Node
    path : Path
    
    init: func(matrix: Matrix) {
        root = Node new(matrix)
        path = Path new()
        path push(root)
    }
    
    run: func {
        //while(true) {
        for(i in 0..3) {
            node := path peek() clone()
            if(node randomize()) {
                printf("After randomization, mat = \n")
                node print()
                path push(node)
            }
        }
    }
    
}
