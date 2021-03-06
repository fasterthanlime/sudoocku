import Matrix, Node, Path
import os/Time, structs/List

Solver: class {
    
    root : Node
    path : Path
    
    init: func(matrix: Matrix) {
        root = Node new(matrix)
        path = Path new()
        path push(root)
    }
    
    run: func {
        srand(Time microsec())
        
        while(true) {
            explore(root)
        }
    }
    
    explore: func (node: Node) {
        
        while(true) {
            node crossOut()
            if(node findUnique()) {
                if(node holes() == 0) {
                    printf("Solution = \n")
                    node print()
                    exit(0)
                }
            } else {
                break
            }
        }
        
        path push(node)
        if(node split()) {
            //printf("Splitted! Exploring...\n")
            //stdin readLine()
            for(child in node list()) {
                explore(child)
            }
        }
        
    }
    
}
