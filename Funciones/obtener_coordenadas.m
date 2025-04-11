function [x, y] = obtener_coordenadas(j, idx, nodo, pos_inicial, Y)
    if isnan(idx(1))
        x = pos_inicial(nodo, 1);
    else
        x = Y(j, idx(1));
    endif
    if isnan(idx(2))
        y = pos_inicial(nodo, 2);
    else
        y = Y(j, idx(2));
    endif
endfunction
