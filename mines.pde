Tile[] board_tiles;

boolean hard_mode = false;

// Hard mode is an 18 * 18 tile board, easy mode is a 9 * 9 tile game
int total_tiles = (hard_mode ? 18 : 9);
int bomb_count = total_tiles - 1;

void setup() {
    size(800, 800);

    board_tiles = new Tile[(int) Math.pow(total_tiles, 2)];

    // Make the board
    int index = 0;
    for (int vertical = 0; vertical < total_tiles; vertical++) {
        for (int horizontal = 0; horizontal < total_tiles; horizontal ++) {
            board_tiles[index++] = new Tile(vertical * (width / total_tiles), horizontal * (width / total_tiles), false);
        }
    }
}

void draw () {
    // Display the board
    for (Tile tile : board_tiles) {
        tile.display(width, (float) total_tiles);
    }
}