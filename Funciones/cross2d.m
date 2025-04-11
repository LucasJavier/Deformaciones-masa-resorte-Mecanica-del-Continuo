function area = cross2d(a_x,a_y,b_x,b_y,c_x,c_y)
    ABx = b_x - a_x;
    ABy = b_y - a_y;
    ACx = c_x - a_x;
    ACy = c_y - a_y;
    area = ABx * ACy - ABy * ACx; % Producto cruz AB × AC
endfunction
