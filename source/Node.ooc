import structs/[List, ArrayList]
import Matrix

Node: class {
    
    matrix: Matrix
    children: List<Node>
    
    init: func(=matrix) {}
    
    add: func(n: Node) {
        list() add(n)
    }
    
    list: func -> List<Node> {
        if(!children) children = ArrayList<Node> new()
        children
    }
    
    clone: func -> This { new(matrix clone()) }
    print: func { matrix print() }
    
    swapRandomly: func (howMany: Int, holy: Matrix) {
        //printf("Should swap %d numbers\n", howMany)
        
        for(i in 0..howMany) {
            okay := false
            x, y: Int
            while(!okay) {
                x = rand() % 9
                y = rand() % 9
                okay = (holy[x, y] == -1)
            }
            
            okay = false
            x2, y2: Int
            while(!okay) {
                x2 = rand() % 9
                y2 = rand() % 9
                okay = (holy[x2, y2] == -1)
            }
            
            //printf("Swapping (%d, %d) with (%d, %d)\n", x, y, x2, y2)
            tmp := matrix[x, y]
            matrix[x, y] = matrix[x2, y2]
            matrix[x2, y2] = tmp
        }
    }
    
    makeHoles: func (howMany: Int, holy: Matrix) {
        for(i in 0..howMany) {
            makePreciseHole(holy)
        }
    }
    
    holes: func -> Int {
        
        holes := 0
        for(y in 0..9) for(x in 0..9) {
            if(matrix[x, y] == -1) holes += 1
        }
        holes
        
    }
    
    score: func -> Int {
        
        score := 0
        
        { // row check
            row : Bool[9]
            for(y in 0..9) {
                for(i in 0..9) row[i] = false
                
                for(x in 0..9) {
                    v := matrix[x, y]
                    if(v == -1) {
                        score -= 1
                        continue
                    }
                    if(row[v - 1] == true) {
                        score -= 1
                    }
                    row[v - 1] = true
                }
            }
        }
        
        { // col check
            col : Bool[9]
            for(x in 0..9) {
                for(i in 0..9) col[i] = false
                
                for(y in 0..9) {
                    v := matrix[x, y]
                    if(v == -1) {
                        score -= 1
                        continue
                    }
                    if(col[v - 1] == true) {
                        score -= 1
                    }
                    col[v - 1] = true
                }
            }
        }
        
        { // cell check
            for(Y in 0..3) {
                for(X in 0..3) {
                    cell : Bool[9]
                    for(i in 0..9) cell[i] = false
                    for(y in 0..3) {
                        for(x in 0..3) {
                            v := matrix[3*X + x, 3*Y + y]
                            if(v == -1) {
                                score -= 1
                                continue
                            }
                            if(cell[v - 1] == true) {
                                score -= 1
                            }
                            cell[v - 1] = true
                        }
                    }
                }
            }
        }
        
        score
        
    }

    makePreciseHole: func (holy: Matrix) {
    
        //printf("\nmakePreciseHole on matrix\n")
        //print()
    
        score := -score()
        if(score == 0) return
        score = rand() % score
        
        { // row check
            row : Bool[9]
            for(y in 0..9) {
                for(i in 0..9) row[i] = false
                
                for(x in 0..9) {
                    v := matrix[x, y]
                    if(v == -1) {
                        continue
                    }
                    if(row[v - 1] == true) {
                        score = score - 1
                        if(score < 0 && holy[x, y] == -1) {
                            //matrix[x, y] = -1
                            yy := y
                            while(yy == y) yy = rand() % 9
                            //printf("Swapping (%d, %d) with (%d, %d)\n", x, y, x, yy)
                            tmp := matrix[x, yy]
                            matrix[x, yy] = matrix[x, y]
                            matrix[x, y]  = tmp
                            return
                        }
                    }
                    row[v - 1] = true
                }
            }
        }
        
        { // col check
            col : Bool[9]
            for(x in 0..9) {
                for(i in 0..9) col[i] = false
                
                for(y in 0..9) {
                    v := matrix[x, y]
                    if(v == -1) {
                        continue
                    }
                    if(col[v - 1] == true) {
                        score = score - 1
                        if(score < 0 && holy[x, y] == -1) {
                            //matrix[x, y] = -1
                            xx := x
                            while(xx == x) xx = rand() % 9
                            //printf("Swapping (%d, %d) with (%d, %d)\n", x, y, xx, y)
                            tmp := matrix[xx, y]
                            matrix[xx, y] = matrix[x, y]
                            matrix[x, y]  = tmp
                            return
                        }
                    }
                    col[v - 1] = true
                }
            }
        }
        
        { // cell check
            for(Y in 0..3) {
                for(X in 0..3) {
                    cell : Bool[9]
                    for(i in 0..9) cell[i] = false
                    for(yy in 0..3) {
                        for(xx in 0..3) {
                            x := 3*X + xx
                            y := 3*Y + yy
                            v := matrix[x, y]
                            if(v == -1) {
                                continue
                            }
                            if(cell[v - 1] == true) {
                                score = score - 1
                                if(score < 0 && holy[x, y] == -1) {
                                    //matrix[x, y] = -1
                                    xx := rand() % 3
                                    yy := rand() % 3
                                    //printf("Swapping (%d, %d) with (%d, %d)\n", X*3 + xx, Y*3 + yy, x, y)
                                    tmp := matrix[x, y]
                                    matrix[x, y] = matrix[X*3 + xx, Y*3 + yy]
                                    matrix[X*3 + xx, Y*3 + yy] = tmp
                                    return
                                }
                            }
                            cell[v - 1] = true
                        }
                    }
                }
            }
        }
    
    }
    
    /**
     * @return true if a randomization was possible, false if not
     */
    randomize: func -> Bool {
        
        isLegal := false
        
        while(!isLegal) {
            isPossible := false
            for(y in 0..9) {
                for(x in 0..9) {
                    if(matrix[x, y] == -1) {
                        isPossible = true
                        break
                    }
                }
                if(isPossible) break
            }
            
            if(!isPossible) return false
            
            x, y: Int
            
            while(true) {
                x = (rand() % 9)
                y = (rand() % 9)
                
                v := matrix[x, y]
                if(v == -1) {
                    matrix[x, y] = (rand() % 9) + 1
                    break
                }
            }
            
            isLegal = isLegal(matrix, x, y)
            //if(!isLegal) matrix[x, y] = -1
        }

        return true
        
    }
    
    isLegal: func(m: Matrix, refX, refY: Int) -> Bool {
        
        v := m[refX, refY]
        
        // check column
        for(x in 0..m getWidth()) {
            if(x == refX) continue
            if(v == matrix[x, refY]) {
                //printf("[column] Not legal because there's another %d at (%d, %d)\n", v, x, refY)
                return false
            }
        }
        
        // check line
        for(y in 0..m getHeight()) {
            if(y == refY) continue
            if(v == matrix[refX, y]) {
                //printf("[line] Not legal because there's another %d at (%d, %d)\n", v, refX, y)
                return false
            }
        }
        
        return true
        
    }
    
}
