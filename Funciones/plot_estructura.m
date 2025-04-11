function plot_estructura(Y, pos_inicial, t, t_step, barras)
    % Coordenadas de los nodos en el instante t_step
    nodos = [
        [0, Y(t_step,1)];          % Nodo 1 (fijo en x)x
        [Y(t_step,2), Y(t_step,3)];       % Nodo 2
        [Y(t_step,4), Y(t_step,5)];       % Nodo 3
        [Y(t_step,6), Y(t_step,7)];       % Nodo 4
        [Y(t_step,8), Y(t_step,9)];       % Nodo 5
        [Y(t_step,10), Y(t_step,11)];     % Nodo 6
        [0, 20];            % Nodo 7 (fijo)
        [Y(t_step,12), Y(t_step,13)];     % Nodo 8
        [Y(t_step,14), Y(t_step,15)];     % Nodo 9
        [Y(t_step,16), Y(t_step,17)];     % Nodo 10
    ];

    % Dibujar las barras (conexiones entre nodos)
    hold on;

    % Dibuja barras
    for i = 1:size(barras, 1)
        nodo_i = barras(i, 1);
        nodo_j = barras(i, 2);
        plot([nodos(nodo_i, 1), nodos(nodo_j, 1)], ...
             [nodos(nodo_i, 2), nodos(nodo_j, 2)], 'b-', 'LineWidth', 1.5);
    endfor

    % Dibuja los nodos
    scatter(nodos(:, 1), nodos(:, 2), 50, 'r', 'filled');

    % Etiquetas
    for i = 1:10
        text(nodos(i, 1), nodos(i, 2), num2str(i), 'Color', 'k', 'FontSize', 12);
    endfor
    hold off;
endfunction
