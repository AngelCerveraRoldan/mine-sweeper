class Tile {
    PImage unclicked_tile = loadImage("tile_img/facingDown.png");

    PImage zero_bomb = loadImage("tile_img/0.png");
    PImage one_bomb = loadImage("tile_img/1.png");
    PImage two_bomb = loadImage("tile_img/2.png");
    PImage three_bomb = loadImage("tile_img/3.png");
    PImage four_bomb = loadImage("tile_img/4.png");
    PImage five_bomb = loadImage("tile_img/5.png");
    PImage six_bomb = loadImage("tile_img/6.png");
    PImage seven_bomb = loadImage("tile_img/7.png");
    PImage eight_bomb = loadImage("tile_img/8.png");

    PImage flagged = loadImage("tile_img/flagged.png");
    PImage bomb_clicked = loadImage("tile_img/bomb.png");

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

    void display(float total_screen, float total_tiles, boolean lost) {
        // Total tiles is the number of tiles per row / col

        // Tiles that havent been clicked on
        if (!marked_safe) { 
            fill(80, 80, 80); 
            // TODO: CHange this to an image
            image(unclicked_tile, x, y, total_screen / total_tiles, total_screen / total_tiles);
        }

        if (marked_safe && !bomb) {
            // TODO: Show this only after user clicks on tile, make it look nicer
            // TODO: If surrounding count is 0, display all tiles around it <----------- IMPORTANT FOR FULL FUNCTIONALITY!!!!!

            if (touching_bomb_count == 0) {
                image(zero_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } else if (touching_bomb_count == 1) {
                image(one_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } else if (touching_bomb_count == 2) {
                image(two_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } else if (touching_bomb_count == 3) {
                image(three_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } else if (touching_bomb_count == 4) {
                image(four_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } else if (touching_bomb_count == 5) {
                image(five_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            }else if (touching_bomb_count == 6) {
                image(six_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } else if (touching_bomb_count == 7) {
                image(seven_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } else if (touching_bomb_count == 8) {
                image(eight_bomb, x, y, total_screen / total_tiles, total_screen / total_tiles);
            } 
        }

        if (marked_as_bomb) {
            image(flagged, x, y, total_screen / total_tiles, total_screen / total_tiles);
        }

        // Clicked on the bomb
        if (lost && bomb) {
            fill(155, 155, 155);
            //square(x, y, total_screen / total_tiles);
            image(bomb_clicked, x, y, total_screen / total_tiles, total_screen / total_tiles);
        }
    }
}