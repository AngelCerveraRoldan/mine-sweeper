class Tile {
    boolean bomb;
    int neighbours;

    int x;
    int y;

    Tile (int x_, int y_, boolean bomb_) {
        x = x_;
        y = y_;

        bomb = bomb_;
    }

    // Increase the number of neighbours this tile has
    void neighbour_inc () {
        neighbours++;
    }    

    // Make a method to increase the neighbout count of all surrounding tiles, this will be more efficient than having each tile check 
    // if their neighbours have a bomb        

    void display(float total_screen, float total_tiles) {
        // Total tiles is the number of tiles per row / col
        if (bomb) {
            fill(255, 80, 80); 
            square(x, y, total_screen / total_tiles);
        } else {
            fill(80, 80, 80); 
            square(x, y, total_screen / total_tiles);
        }
    }
}