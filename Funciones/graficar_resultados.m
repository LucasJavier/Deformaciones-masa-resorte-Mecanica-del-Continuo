function graficar_resultados(t, Y, pos_inicial, figura_idx, es_sinusoidal, frec, nombre)
    % Configurar figura para nodos
    figure(figura_idx, 'Position', [50, 50, 900, 750], 'Name', nombre);
    nodos = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10'};
    idx = 2;
    for i = 1:10
        subplot(5, 2, i);
        if i == 1 % Nodos fijos
            plot(t, zeros(size(t)), 'k-', ...
                 t, Y(:,1), 'r-');
        elseif i == 7
            plot(t, repmat(pos_inicial(i,1), size(t)), 'k-', ...
                 t, repmat(pos_inicial(i,2), size(t)), 'r-');
        else
          plot(t, Y(:,idx), 'k-', t, Y(:,idx+1), 'r-');
          idx = idx + 2;
        endif
       xlabel('Tiempo (s)'); ylabel('Posición (m)');
        legend('x', 'y', 'Location', 'northeast');
       if es_sinusoidal
         title(['Nodo: ' nodos{i}, ' - Frecuencia: ' num2str(frec)]);
       else
         title(['Nodo: ' nodos{i}]);
       endif
    endfor
    figura_idx = figura_idx + 1;
    pause(2)

    % Configurar figura para evolución global
    figure(figura_idx, 'Position', [100, 100, 800, 600], 'Name', nombre);
    colores = lines(10);

    % Posiciones X
    subplot(2,1,1); hold on;
    idx = 2;
    for i = 1:10
        if i == 1
            plot(t, zeros(size(t)), 'Color', colores(i,:), 'LineWidth',1.5);
        elseif i == 7
            plot(t, repmat(pos_inicial(i,1), size(t)), 'Color', colores(i,:), 'LineWidth',1.5);
        else
            plot(t, Y(:,idx), 'Color', colores(i,:), 'LineWidth',1.5);
            idx = idx + 2;
        endif
    endfor
    if es_sinusoidal
      title(['Evolución de Posiciones X. ','Frecuencia: ' num2str(frec)]);
    else
      title('Evolución de Posiciones X');
    endif
    xlabel('Tiempo (s)'); ylabel('X (m)');
    legend(nodos, 'Location', 'northeast');
    grid on;
    #yticks(-150:10:40);

    % Posiciones Y
    subplot(2,1,2); hold on;
    idx = 3;
    for i = 1:10
        if i == 1
            plot(t, zeros(size(t)), 'Color', colores(i,:), 'LineWidth',1.5);
        elseif i == 7
            plot(t, repmat(pos_inicial(i,2), size(t)), 'Color', colores(i,:), 'LineWidth',1.5);
        else
            plot(t, Y(:,idx), 'Color', colores(i,:), 'LineWidth',1.5);
            idx = idx + 2;
        endif
    endfor
    if es_sinusoidal
      title(['Evolución de Posiciones Y. ', 'Frecuencia: ' num2str(frec)]);
    else
      title('Evolución de Posiciones Y');
    endif
    xlabel('Tiempo (s)'); ylabel('Y (m)');
    legend(nodos, 'Location', 'northeast');
    grid on;
    %yticks(-150:10:40);
    pause(2)
endfunction
