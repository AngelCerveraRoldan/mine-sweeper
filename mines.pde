// This variable will be used to generage a grid of the desired width and height
int tiles_per_row = 15;
Tile[] tiles = new Tile[(int) Math.pow(tiles_per_row, 2)];

int tile_width;
// Because the bombs are randomly generated, we dont know how many there will be before the game begings, so every time we generate a bomb
// we will add one to the bomb count, this variable will be used to see if the user has won later
int bomb_count = 0;
// This variable will have one added onto it every time the a tile that is not a bomb is clicked
int safe_click = 0;

boolean lost = false;
boolean won = false; 

void setup () {
    size(800, 800);
    tile_width = width / tiles_per_row;

    // Generate tiles
    for (int i = 0; i < Math.pow(tiles_per_row, 2); i ++) {
        int[] coords = index_to_coord(i);
        
        // Roughly 20% of tiles will be bombs
        boolean bomb_random = false;
        if ((random(99) + 1) < 20) {
            bomb_random = true;
            bomb_count ++;
        }

        tiles[i] = new Tile(coords[0] * tile_width, coords[1] * tile_width, bomb_random);        
    }

    // Update surrounding bomb count
    for (int i = 0; i < Math.pow(tiles_per_row, 2); i ++) {
        if (tiles[i].is_bomb) {
            count_around(i);
        }
    }
}

void draw () {
    // If the number of tiles that have been clicked on is the same as the total tiles minus the number of bombs, 
    // that means every non bomb tile has been clicked and the player wins
    if (safe_click == (int) Math.pow(tiles_per_row, 2) - bomb_count) {
        won = true;
    }

    if (!won && !lost) {
        // Draw tiles
        for (Tile tile : tiles) {
            tile.display(tiles_per_row, tile_width);
        }
    } else if (won) {
        for (Tile tile : tiles) {
            tile.been_clicked = true;

            tile.display(tiles_per_row, tile_width);
        }

        // Show you win text
        textSize(100);
        fill(0, 255, 100);
        textAlign(CENTER);
        text("You have won!", 400, 400);
    } else if (lost) {
        for (Tile tile : tiles) {
            tile.been_clicked = true;

            tile.display(tiles_per_row, tile_width);
        }

        // Show you loose text
        textSize(100);
        fill(255, 0, 100);
        textAlign(CENTER);
        text("You have lost!", 400, 400);
    }


}

void mouseClicked() {
    int[] clicked_coordinates = {
        (int) (mouseX) / (width / tiles_per_row),
        (int) (mouseY) / (width / tiles_per_row),
    };

    int clicked_index = clicked_coordinates[0] + clicked_coordinates[1] * tiles_per_row;
    if (mouseButton == LEFT) {
        click_on_tile(clicked_index);
    } else if (mouseButton == RIGHT && !tiles[clicked_index].been_clicked) {
        tiles[clicked_index].been_flagged = !tiles[clicked_index].been_flagged;
    } 
}

// This function will be used when a tile is left clicked
// A tile is left clicked when the player thinks that it is NOT a bomb
// If it isnt a bomb, we will turn it over to show how many bombs surround it, if it is a bomb, the player will lose
void click_on_tile(int index) {
    // We first make sure that the tile hasnt been flagged or already cicked
    // It it has already been clicked, then there is no point on clicking on it again as it would do nothing
    // If it has been flagged, that means the player thinks that the tile hides a bomb, so if a flagged tile is clicked we do nothing to avoid accidental clicks
    if (!tiles[index].been_clicked && !tiles[index].been_flagged) {        
        if (lost == false) {
            // Clicking on a tile returns true if its a bomb
            lost = tiles[index].main_click();
            safe_click ++;
            println(safe_click);
        }
    } 

    // If the surrounding bomb count is 0, then we know that every tile surrounding it is NOT a bomb
    // We will run a recursive call that will click on every tile that exist surrounding a tile that has a surrounding bomb count of 0
    // This is important (specially in big grids) as it would be very annoying for the player to have to click, say 50 tiles that all have a 0 surrouding bomb count
    if (tiles[index].surrounding_bomb_count == 0) {
        int[] coordinate = index_to_coord(index);
        int x = coordinate[0];
        int y = coordinate[1];

        // The following if statments check if the tile exists, and if it does it clicks on it
        // For example, the tiles on the very right of the board, will not have a tile to their right to be clicked on

        if (y != 0 && (!tiles[index - tiles_per_row].been_clicked && !tiles[index - tiles_per_row].been_flagged)) {
            click_on_tile(index - tiles_per_row);

            if (x != 0 && (!tiles[(index - tiles_per_row) - 1].been_clicked && !tiles[(index - tiles_per_row) - 1].been_flagged)) {
                click_on_tile((index - tiles_per_row) - 1);
            }

            if (x != (tiles_per_row - 1) && (!tiles[(index - tiles_per_row) + 1].been_clicked && !tiles[(index - tiles_per_row) + 1].been_flagged)) {
                click_on_tile((index - tiles_per_row) + 1);
            }
        }
        
        if (y != (tiles_per_row - 1) && (!tiles[index + tiles_per_row].been_clicked && !tiles[index + tiles_per_row].been_flagged)) {
            click_on_tile(index + tiles_per_row);

            if (x != 0 && (!tiles[(index + tiles_per_row) - 1].been_clicked && !tiles[(index + tiles_per_row) - 1].been_flagged)) {
                click_on_tile((index + tiles_per_row) - 1);
            }

            if (x != (tiles_per_row - 1) && (!tiles[(index + tiles_per_row) + 1].been_clicked && !tiles[(index + tiles_per_row) + 1].been_flagged)) {
                click_on_tile((index + tiles_per_row) + 1);
            }
        }

        if (x != 0 && (!tiles[index - 1].been_clicked && !tiles[index - 1].been_flagged)) {
            click_on_tile(index - 1);
        }

        if (x != (tiles_per_row - 1) && (!tiles[index + 1].been_clicked && !tiles[index + 1].been_flagged)) {
            click_on_tile(index + 1);
        }
    }

}

// This function will translate a tiles index, to its (x, y) coordinate
int[] index_to_coord (int index) {
    int[] coordinates = new int[2];

    // Find x coordinate
    coordinates[0] = index % tiles_per_row;

    // Find y coordinate
    coordinates[1] = (int) index / tiles_per_row;

    return coordinates;
}

// This function will add one to the surrounding bomb count to every tile around its index
// Run this function passing the index of each bomb as a parameter
void count_around (int index) {
    int x = index_to_coord(index)[0];
    int y = index_to_coord(index)[1];

    if (y != (tiles_per_row - 1)) { // In this case there will be a tile right above
        // index below is the same index + the ammount of tiles in a row
        tiles[index + tiles_per_row].surrounding_bomb_count ++;    
    }

    if (y != 0) { // In this case there must be a tile right above
        // Index above is the index - the tiles in a row
        tiles[index - tiles_per_row].surrounding_bomb_count ++;        
    }

    if (x != (tiles_per_row - 1)) { // There will be a tile to the right
        tiles[index + 1].surrounding_bomb_count ++;

        if (y != 0) { // This has a tile to the right and up
            tiles[(index + 1) - tiles_per_row].surrounding_bomb_count ++;
        }

        if (y != (tiles_per_row - 1)) { // This has a tile to the right and down
            tiles[(index + 1) + tiles_per_row].surrounding_bomb_count ++;
        }
    }

    if (x != 0) {// There will be a tile to the left
        tiles[index - 1].surrounding_bomb_count ++;

        if (y != 0) { // This has a tile to the left and up
            tiles[(index - 1) - tiles_per_row].surrounding_bomb_count++;
        }

        if (y != (tiles_per_row - 1)) { // This has a tile to the left and down
            tiles[(index - 1) + tiles_per_row].surrounding_bomb_count ++;
        }
    }
}



