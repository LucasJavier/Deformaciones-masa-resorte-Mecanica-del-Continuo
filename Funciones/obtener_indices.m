function idx = obtener_indices(nodos)
    % Mapeo de nodo a índices en Y
    % nodos: lista de nodos del triángulo (ejemplo: [1, 2, 3])
    % Devuelve índices de [x1, y1, x2, y2, x3, y3] en Y.

    % Diccionario de nodo a índices (x e y)
    nodo_a_indices = containers.Map(...
        {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, ...
        {[NaN, 1], [2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [NaN, NaN],...
        [12, 13], [14, 15], [16, 17]} ...
    );

    idx = [];
    for nodo = nodos
        indices_nodo = nodo_a_indices(nodo);
        idx = [idx, indices_nodo(1), indices_nodo(2)]; % Agrega x e y
    endfor
endfunction
