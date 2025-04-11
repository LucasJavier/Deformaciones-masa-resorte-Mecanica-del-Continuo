function tF = encontrar_tF(t, Y, pos_inicial)
    % Lista de triángulos (ejemplo para Caso 5, ajusta según tu estructura)
    triangulos = {
        [1, 3, 2],    % Barra 1, 2, 3
        [3, 7, 2],    % Barra 5, 4, 2
        [3, 8, 7],    % Barra 6, 7, 5
        [3, 4, 8],    % Barra 8, 9, 6
        [4, 9, 8],    % Barra 10, 11, 9
        [4, 5, 9],    % Barra 12, 13, 10
        [5, 10, 9],   % Barra 14, 15, 13
        [5, 6, 10]    % Barra 16, 17, 14
    };

    tF = 50; % Valor máximo (tF Max)
    for i = 1:length(triangulos)
        nodos = triangulos{i};
        % Obtener índices de los nodos en Y (depende de tu implementación)
        idx = obtener_indices(nodos); % Función auxiliar para mapear nodos a índices en Y
        for j = 1:length(t)-1
            % Coordenadas en t(j)
            [A_x, A_y] = obtener_coordenadas(j, idx(1:2), nodos(1), pos_inicial, Y);
            [B_x, B_y] = obtener_coordenadas(j, idx(3:4), nodos(2), pos_inicial, Y);
            [C_x, C_y] = obtener_coordenadas(j, idx(5:6), nodos(3), pos_inicial, Y);
            % Área en t(j)
            area_prev = cross2d(A_x,A_y,B_x,B_y,C_x,C_y);

            % Coordenadas en t(j+1)
            [A_xn, A_yn] = obtener_coordenadas(j+1, idx(1:2), nodos(1), pos_inicial, Y);
            [B_xn, B_yn] = obtener_coordenadas(j+1, idx(3:4), nodos(2), pos_inicial, Y);
            [C_xn, C_yn] = obtener_coordenadas(j+1, idx(5:6), nodos(3), pos_inicial, Y);
            area_next = cross2d(A_xn,A_yn,B_xn,B_yn,C_xn,C_yn);

            % --- Detectar cambio de signo ---
            if sign(area_prev) ~= sign(area_next)
                tF = min(tF, t(j+1));
                break;
            endif
        endfor
    endfor
endfunction
