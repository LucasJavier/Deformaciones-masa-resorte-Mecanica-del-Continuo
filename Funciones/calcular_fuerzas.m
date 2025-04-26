% Función auxiliar para recalcular fuerzas y nodo_b
function [F_a, F_a_N, F_a_T, nodo_b] = calcular_fuerzas(Y, kij, pos_inicial, grandes_deformaciones, A)
    F_a = zeros(size(Y,1), 1);    % Vector para fuerza en barra 'a'
    F_a_N = zeros(size(Y,1), 1);  % Vector para fuerza Normal en barra 'a'
    F_a_T = zeros(size(Y,1), 1);  % Vector para fuerza Tangencial en barra 'a'
    nodo_b = zeros(size(Y,1), 2); % Matriz para [x6, y6]
       for i = 1:size(Y,1)
        % Coordenadas actuales del nodo 6 (b) y nodo 10 (barra a: 6-10)
        Xi = [Y(i, 10), Y(i, 11)]; % Nodo 6 (b)
        Xj = [Y(i, 16), Y(i, 17)]; % Nodo 10

        % Fuerza en la barra 6-10 (barra 'a' en Caso 5)
        [Fx, Fy] = fuerza_resorte(Xi, Xj, kij, pos_inicial(6,:),...
                                   pos_inicial(10,:), grandes_deformaciones);
        F_a(i) = norm([Fx, Fy]);  % Magnitud de la fuerza
        F_a_N(i) = F_a(i)/A;      % Tensión normal (σ = F/A)
        F_a_T(i) = 0;             % Componente tangencial (cero)
        % En un reticulado ideal con barras articuladas, no existe tensión tangencial
        % en ninguna hipótesis (grandes o pequeñas deformaciones), ya que las barras
        % solo transmiten fuerzas axiales (normales a la sección transversal).
        % La componente tangencial es inherentemente cero.
        nodo_b(i,:) = Xi;   % Posición del nodo 6 (b)
    endfor
endfunction
