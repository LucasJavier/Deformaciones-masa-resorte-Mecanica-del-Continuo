% Función auxiliar para calcular la fuerza_resorte
function [Fx, Fy] = fuerza_resorte(Xi, Xj, kij, Xi0, Xj0, grandes_deformaciones)
    L0 = norm(Xj0 - Xi0);          % Longitud inicial
    L = norm(Xj - Xi);             % Longitud actual
    if L == 0
        Fx = 0; Fy = 0;            % Evitamos división por cero
    else
        if grandes_deformaciones
          direccion = (Xj - Xi); % Grandes deformaciones
          F_magnitud = kij * (1 - L0/L); % Magnitud de la fuerza
        % La dirección de la fuerza se calcula usando la posición actual de los
        % nodos (Xi, Xj)
        else
          direccion = (Xj0 - Xi0); % Pequeñas deformaciones
          F_magnitud = kij * (L/L0 - 1); % Magnitud de la fuerza
        % La dirección de la fuerza se fija según la configuración inicial
        % (Xi0, Xj0), ignorando los cambios de dirección por deformación.
      endif
        Fx = F_magnitud * direccion(1);
        Fy = F_magnitud * direccion(2);
    endif
endfunction
