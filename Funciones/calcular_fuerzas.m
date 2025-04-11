% Función auxiliar para recalcular fuerzas y nodo_b
function [F_a, nodo_b] = calcular_fuerzas(Y, kij, pos_inicial, grandes_deformaciones)
    F_a = zeros(size(Y,1), 1);    % Vector para fuerza en barra 'a'
    nodo_b = zeros(size(Y,1), 2); % Matriz para [x6, y6]
       for i = 1:size(Y,1)
        % Coordenadas actuales del nodo 6 (b) y nodo 10 (barra a: 6-10)
        x6 = Y(i, 10);
        y6 = Y(i, 11);
        x10 = Y(i, 16);
        y10 = Y(i, 17);

        % Fuerza en la barra 6-10 (barra 'a' en Caso 5)
        [Fx, Fy] = fuerza_resorte([x6, y6], [x10, y10], kij, ...
                    pos_inicial(6,:), pos_inicial(10,:), grandes_deformaciones);

        F_a(i) = norm([Fx, Fy]);  % Magnitud de la fuerza
        nodo_b(i,:) = [x6, y6];   % Posición del nodo 6 (b)
    endfor
endfunction
