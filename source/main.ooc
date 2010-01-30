import structs/Array, io/FileReader, text/StringTokenizer
import Matrix, Solver

// wooh, globals are evil
appName := ""

usage: func {
    printf("Usage: %s fileName\n", appName)
}

main: func (args: Array<String>) {
 
    appName = args[0]
    
    if(args size() < 2) {
        usage()
        exit(0)
    }
    
    width  := 9
    height := 9
    
    m := Matrix new(width, height)
    fr := FileReader new(args[1])
    
    for(y in 0..height) {
        
        line := fr readLine() trim()
        // skip blank lines
        while(line isEmpty()) line = fr readLine() trim()
        
        st := StringTokenizer new(line, ' ')
        
        for(x in 0..width) {
            if(!st hasNext()) {
                printf("Missing value! Expected %dx%d = %d values\n", width, height, width * height)
                exit(0)
            }
            m set(x, y, st nextToken() toInt())
        }
    }
    
    "initial matrix = " println()
    m print()
    
    Solver new(m) run()
    
}