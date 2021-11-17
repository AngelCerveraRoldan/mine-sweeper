class Tile {
    // Is the tile a bomb
    boolean bomb;

    // Has the user marked the tile as a bomb
    boolean marked_as_bomb = false;

    // Number of neighbouring bombs
    int touching_bomb_count;

    // Top left coord
    int x;
    int y;

    // When user clicks, run a function that will:
    // -> End the game if it is a bomb
    // -> Show neighbour number if it isnt a bomb    
    boolean marked_safe = false;

    Tile (int x_, int y_, boolean bomb_) {
        x = x_;
        y = y_;

        bomb = bomb_;
    }

    // Increase the number of neighbours this tile has
    void neighbour_inc () {
        touching_bomb_count++;
    }    

    boolean is_safe () {
        marked_safe = true;
        
        return bomb;                
    }

    // Make a method to increase the neighbout count of all surrounding tiles, this will be more efficient than having each tile check 
    // if their neighbours have a bomb        

    void display(float total_screen, float total_tiles) {
        // Total tiles is the number of tiles per row / col
        if (!marked_safe) {
            fill(80, 80, 80); 
            square(x, y, total_screen / total_tiles);
        }

        if (marked_safe && !bomb) {
            // TODO: Show this only after user clicks on tile, make it look nicer
            // TODO: If surrounding count is 0, display all tiles around it <----------- IMPORTANT FOR FULL FUNCTIONALITY!!!!!
            fill(0, 255, 120);
            square(x, y, total_screen / total_tiles);

            fill(120, 120, 120);
            textSize(50);
            text(touching_bomb_count, x + (width / (2 * total_tiles)) - 12, y + (width / (2 * total_tiles)) + 12);
        }
    }
}