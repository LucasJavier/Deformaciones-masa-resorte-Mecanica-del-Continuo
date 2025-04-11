function animar_estructura(Y, t, tF_idx, fig_num, paso, pos_inicial, barras)
    figure(fig_num);
    axis equal;
    grid on;
    xlabel('X'); ylabel('Y');
    for t_step = 1:paso:length(tF_idx)
        cla;
        plot_estructura(Y, pos_inicial, t, t_step, barras);
        title(['Estructura en t = ', num2str(t(t_step))]);
        pause(0.1); % Controla la velocidad de la animación
    endfor
    pause(2) % Esperamos 2 segunos cuando finaliza la animacion
endfunction
