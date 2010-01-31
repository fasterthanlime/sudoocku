import structs/List, Hut

version(unix || apple) {
    Matrix lowerLeft  = "└"
    Matrix lowerRight = "┘"
    Matrix upperLeft  = "┌"
    Matrix upperRight = "┐"
    Matrix horiz      = "─"
    Matrix vert       = "│"
}

version (!(unix || apple)) {
    Matrix lowerLeft  = "\\"
    Matrix lowerRight = "/"
    Matrix upperLeft  = "/"
    Matrix upperRight = "\\"
    Matrix horiz      = "-"
    Matrix vert       = "|"
}

Matrix: class {
    
    lowerLeft, upperLeft, lowerRight, upperRight, horiz, vert : static String
    
    width, height: Int
    data: Hut*
    
    init: func ~fromSize (=width, =height) {
        data = gc_malloc(Hut size * width * height)
        for(y in 0..height) for(x in 0..width) {
            this[x, y] = Hut new(-1)
        }
    }
    
    init: func ~copy (src: This) {
        this(src width, src height)
        for(y in 0..height) for(x in 0..width) {
            this[x, y] = src[x, y] clone()
        }
    }
    
    clone: func -> This { new(this) }
    
    set: func (x, y: Int, val: Hut) {
        data[x + y * width] = val
    }
    
    get: func (x, y: Int) -> Hut {
        return data[x + y * width]
    }
    
    rowSwap: func (row1, row2: Int) {
        for(x in 0..width) {
            tmp := this[x, row1]
            this[x, row1] = this[x, row2]
            this[x, row2] = tmp
        }
    }

    print: func {
        xspacing := 3
        
        printf("%s", upperLeft)
        for(x in 0..(width * xspacing + 8)) printf("%s", horiz)
        printf("%s\n", upperRight)
        
        for(y in 0..height) {
            printf("%s", vert)
            for(x in 0..width) {
                val := get(x, y) getValue()
                if(val == -1) {
                    printf("  .")
                } else {
                    printf("  %d", val)
                }
                if((x + 1) % 3 == 0) printf("  %s", vert)
            }
            printf("\n")
            
            if(y != (height - 1) && (y + 1) % 3 == 0) {
                printf(" ")
                for(x in 0..(width * xspacing + 8)) printf("%s", horiz)
                printf("\n")
            }
        }
        
        printf("%s", lowerLeft)
        for(x in 0..(width * xspacing + 8)) {
            printf("%s", horiz)
        }
        printf("%s\n", lowerRight)
    }
    
    getWidth:  func -> Int { width }
    getHeight: func -> Int { height }

}

operator []  (m: Matrix, x, y: Int) -> Hut    { m get(x, y) }
operator []= (m: Matrix, x, y: Int, val: Hut) { m set(x, y, val) }
