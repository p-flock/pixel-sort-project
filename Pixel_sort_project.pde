PImage source;
PImage dest;

String IMG_NAME = "austin_badlands.jpg"
int IMG_HEIGHT = 2048;
int IMG_WIDTH = 1366;
int count = 0;

void setup(){
    size(IMG_HEIGHT, IMG_WIDTH);
    source = loadImage(IMG_NAME);
    source.loadPixels();
    dest = createImage(source.width, source.height, RGB);
    for (int x = 0; x < source.width; x++) {
        for (int y= 0; y < source.height; y++) {
            int loc = x + y*source.width;
            dest.pixels[loc] = source.pixels[loc];
        }
    }
}

void draw() {
    //color[] pixel_row = new color[source.height];
    color current_pix = source.pixels[0];
    color prev_pix = source.pixels[0];
    int section_start = 0;
    int section_end = 0;

    for (int x = 0; x < source.width; x++) {
        section_start = 0;
        section_end = 0;
        while (section_start < source.height - 1) {
            int loc = x + section_end * source.width;
            current_pix = source.pixels[loc];

            if(abs(brightness(current_pix) - brightness(prev_pix)) > count || section_end >= source.height - 1) {
                /*print("x = " + x + " y_start = " + section_start + " y_end = " + section_end);*/
                color[] sort_row = new color[section_end - section_start];
                for (int y = section_start; y < section_end; y++){
                    sort_row[y - section_start] = source.pixels[x+y*source.width];
                }
                //sort_row = sort_colors(x, section_start, section_end);
                sort_row = sort(sort_row);
                //sort_row = sort_colors(x, section_start, section_end);

                for (int y = section_start; y < section_end; y++){
                    dest.pixels[x+y*source.width] = sort_row[y - section_start];
                }

       /*replace_pixels(x, section_start, section_end, sort_colors(x, section_start, section_end));*/
                section_start = section_end;
                section_end++;
                prev_pix = source.pixels[loc];
            }else {
                section_end++;
                prev_pix = source.pixels[loc];
            }
        }
    }
    /*for (int x = 0; x < source.width; x++) {*/
        /*for (int y= 0; y < source.height; y++) {*/
            /*int loc = x + y*source.width;*/
            /*current_pix = source.pixels[loc];*/
            /*section_end = y;*/
            /*if (abs(brightness(current_pix) - brightness(prev_pix)) > 120) {*/
                /*break;*/
            /*}*/
        /*}*/
        /*color[] sort_row = new color[section_end - section_start];*/
        /*for (int y = section_start; y < section_end; y++){*/
            /*sort_row[y - section_start] = source.pixels[x+y*source.width];*/
        /*}*/
        /*//sort_row = sort_colors(x, section_start, section_end);*/
        /*sort_row = sort(sort_row);*/
        /*//sort_row = sort_colors(x, section_start, section_end);*/

        /*for (int y = section_start; y < section_end; y++){*/
            /*dest.pixels[x+y*source.width] = sort_row[y - section_start];*/
        /*}*/
    /*}*/
    dest.updatePixels();
    // Display the destination
    image(dest,0,0);
    save("test" + count + ".jpg");
    /*print("just passed save line");*/
    count++;
    if (count > 255) {noLoop();}
}

color[] sort_colors(int x, int y_start, int y_end) {
    color[] pixel_range = new color[y_end - y_start];
    for (int y = y_start; y < y_end; y++) {
        pixel_range[y - y_start] = source.pixels[x+y*source.width];
    }
    pixel_range = sort(pixel_range);
    return pixel_range;
}

color[] sort_pixels(color[] pixels) {
    color[] sorted =  new color[pixels.length];

    sorted = sort(pixels);
    return sorted;
}

color[] copy_pixels(int x, int y_start, int y_end) {

    color[] copy = new color[y_end - y_start];

    for (int y = y_start; y < y_end; y++) {
        copy[y - y_start] = source.pixels[x+y*source.width];
    }
    return copy;
}

void replace_pixels(int x, int y_start, int y_end, color[] new_pixels) {
    /*for (int y = y_start; y < y_end; y++) {*/
        /*new_pixels[y - y_start] = source.pixels[x+y*source.width];*/
    /*}*/
    for (int y = y_start; y < y_end; y++){
        dest.pixels[x+y*source.width] = new_pixels[y - y_start];
    }
    dest.updatePixels();
    return;
}
