function [max_desp, t_max_desp] = maximo_desplazamiento(idx,pos_inicial_flat,Y,t)
    max_desp = 0;
    t_max_desp = 0;
    for i = 1:idx % Hasta el limite temporal
        Y_actual = Y(i, 1:17); % Posiciones actuales (tiempo 'i')
        desplazamientos = Y_actual - pos_inicial_flat;
        normas = [];
        % Nodo 1 (solo y)
        normas(1) = abs(desplazamientos(1));
        % Nodos 2,3,4,5,6,8,9,10 (x,y)
        for nodo = 2:9
            x = desplazamientos(2*(nodo-1));
            y = desplazamientos(2*(nodo-1)+1);
            normas(nodo) = norm([x, y]);
        endfor
        current_max = max(normas);
        if current_max > max_desp
            max_desp = current_max;
            t_max_desp = t(i);
        endif
    endfor
endfunction
