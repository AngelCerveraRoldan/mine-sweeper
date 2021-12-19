class Tile {  
    // This are all the possible images for each tile
    // I found them by googling 'minesweeper tile images' on google, the first link had all the images i needed
    // https://github.com/pardahlman/minesweeper/tree/master/Images
    PImage[] tile_images = {
        loadImage("tile_img/0.png"),
        loadImage("tile_img/1.png"),
        loadImage("tile_img/2.png"),
        loadImage("tile_img/3.png"),
        loadImage("tile_img/4.png"),
        loadImage("tile_img/5.png"),
        loadImage("tile_img/6.png"),
        loadImage("tile_img/7.png"),
        loadImage("tile_img/8.png"),

        loadImage("tile_img/facingDown.png"), // [9]
        loadImage("tile_img/bomb.png"), // [10]
        loadImage("tile_img/flagged.png"), // [11]
    };
        
    
    // Tile coordinates
    int x;
    int y;
    int surrounding_bomb_count = 0;

    boolean is_bomb; // Is the tile a bomb?
    boolean been_clicked = false; // Has this tile been clicked?
    boolean been_flagged = false;

    Tile(int x_, int y_, boolean is_bomb_) {
        x = x_;
        y = y_;
        is_bomb = is_bomb_;
    }


    // This means that the tile has been clicked, if it is a bomb, return true, which indicated the player has lost
    boolean main_click() {
        been_clicked = true; 

        // If its a bomb, you loose
        if (is_bomb) {
            return true;
        } else {
            return false;
        }
    }

    void display(int tiles_per_row, int tile_width) {
        // Defualt image
        PImage img = tile_images[9];

        // Change image if neccessary
        if (is_bomb && been_clicked) {
            img = tile_images[10];
        } else if (been_clicked) {
            // Images were ordered so that the 0th index would be the image with 0 bombs around it and so on
            img = tile_images[surrounding_bomb_count];
        } else if (been_flagged) {
            img = tile_images[11];
        }   

        image(img, x, y, tile_width, tile_width);
    }
}
