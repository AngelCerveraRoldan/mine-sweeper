boolean bomb;
int neighbours;

int x;
int y;

class Tile {
    Tile (int x_, int y_, int bomb_) {
        x = x_;
        y = y_;

        bomb = bomb_;
    }

    // Increase the number of neighbours this tile has
    void neighbour_inc () {
        neighbours++;
    }    
}