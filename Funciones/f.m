function dYdt = f(t, Y, kij, pos_inicial, m, grandes_deformaciones, es_sinusoidal, frec)
    % Posiciones fijas
    y1 = pos_inicial(1, 2);  % y1 fijo
    x7 = pos_inicial(7, 1); y7 = pos_inicial(7, 2); % Nodo 7 fijo

    % Carga P(t)
    if es_sinusoidal
        P_t = sin(2*pi*frec*t);
        P = [P_t, P_t];
    else
        P = [1.2, 1.2]; % Carga original
    endif

    % Extraer posiciones
    y1 = Y(1);
    x2 = Y(2); y2 = Y(3);
    x3 = Y(4); y3 = Y(5);
    x4 = Y(6); y4 = Y(7);
    x5 = Y(8); y5 = Y(9);
    x6 = Y(10); y6 = Y(11);
    x8 = Y(12); y8 = Y(13);
    x9 = Y(14); y9 = Y(15);
    x10 = Y(16); y10 = Y(17);

    % Calcular fuerzas (grandes o pequeñas deformaciones)
    [F12x, F12y] = fuerza_resorte([0, y1], [x2, y2], kij(1), [0, pos_inicial(1,2)], pos_inicial(2,:),grandes_deformaciones);
    [F13x, F13y] = fuerza_resorte([0, y1], [x3, y3], kij(2), [0, pos_inicial(1,2)], pos_inicial(3,:),grandes_deformaciones);
    [F23x, F23y] = fuerza_resorte([x2, y2], [x3, y3], kij(3), pos_inicial(2,:), pos_inicial(3,:),grandes_deformaciones);
    [F27x, F27y] = fuerza_resorte([x2, y2], [x7, y7], kij(4), pos_inicial(2,:), pos_inicial(7,:),grandes_deformaciones);
    [F34x, F34y] = fuerza_resorte([x3, y3], [x4, y4], kij(5), pos_inicial(3,:), pos_inicial(4,:),grandes_deformaciones);
    [F37x, F37y] = fuerza_resorte([x3, y3], [x7, y7], kij(6), pos_inicial(3,:), pos_inicial(7,:),grandes_deformaciones);
    [F38x, F38y] = fuerza_resorte([x3, y3], [x8, y8], kij(7), pos_inicial(3,:), pos_inicial(8,:),grandes_deformaciones);
    [F45x, F45y] = fuerza_resorte([x4, y4], [x5, y5], kij(8), pos_inicial(4,:), pos_inicial(5,:),grandes_deformaciones);
    [F48x, F48y] = fuerza_resorte([x4, y4], [x8, y8], kij(9), pos_inicial(4,:), pos_inicial(8,:),grandes_deformaciones);
    [F49x, F49y] = fuerza_resorte([x4, y4], [x9, y9], kij(10), pos_inicial(4,:), pos_inicial(9,:),grandes_deformaciones);
    [F56x, F56y] = fuerza_resorte([x5, y5], [x6, y6], kij(11), pos_inicial(5,:), pos_inicial(6,:),grandes_deformaciones);
    [F59x, F59y] = fuerza_resorte([x5, y5], [x9, y9], kij(12), pos_inicial(5,:), pos_inicial(9,:),grandes_deformaciones);
    [F510x, F510y] = fuerza_resorte([x5, y5], [x10, y10], kij(13), pos_inicial(5,:), pos_inicial(10,:),grandes_deformaciones);
    [F610x, F610y] = fuerza_resorte([x6, y6], [x10, y10], kij(14), pos_inicial(6,:), pos_inicial(10,:),grandes_deformaciones);
    [F78x, F78y] = fuerza_resorte([x7, y7], [x8, y8], kij(15), pos_inicial(7,:), pos_inicial(8,:),grandes_deformaciones);
    [F89x, F89y] = fuerza_resorte([x8, y8], [x9, y9], kij(16), pos_inicial(8,:), pos_inicial(9,:),grandes_deformaciones);
    [F910x, F910y] = fuerza_resorte([x9, y9], [x10, y10], kij(17), pos_inicial(9,:), pos_inicial(10,:),grandes_deformaciones);

    % Ecuaciones de aceleración
    dv1dt = (F12y + F13y) / m(1);
    du2dt = (-F12x + F23x + F27x) / m(2);
    dv2dt = (-F12y + F23y + F27y) / m(2);
    du3dt = (-F13x -F23x + F34x + F37x + F38x) / m(3);
    dv3dt = (-F13y -F23y + F34y + F37y + F38y) / m(3);
    du4dt = (-F34x + F45x + F48x + F49x) / m(4);
    dv4dt = (-F34y + F45y + F48y + F49y) / m(4);
    du5dt = (-F45x + F56x + F59x + F510x) / m(5);
    dv5dt = (-F45y + F56y + F59y + F510y) / m(5);
    du6dt = (-F56x + F610x + P(1)) / m(6);
    dv6dt = (-F56y + F610y - P(2)) / m(6);
    du8dt = (-F38x - F48x + F78x + F89x) / m(8);
    dv8dt = (-F38y - F48y + F78y + F89y) / m(8);
    du9dt = (-F49x - F59x - F89x + F910x) / m(9);
    dv9dt = (-F49y - F59y - F89y + F910y) / m(9);
    du10dt = (-F510x - F610x - F910x) / m(10);
    dv10dt = (-F510y - F610y - F910y) / m(10);

    % Vector derivadas
    dYdt = [
        Y(18);          % dy2/dt
        Y(19); Y(20);   % dx2/dt, dy2/dt
        Y(21); Y(22);   % dx3/dt, dy3/dt
        Y(23); Y(24);   % dx4/dt, dy4/dt
        Y(25); Y(26);   % dx5/dt, dy5/dt
        Y(27); Y(28);   % dx6/dt, dy6/dt
        Y(29); Y(30);   % dx8/dt, dy8/dt
        Y(31); Y(32);   % dx9/dt, dy9/dt
        Y(33); Y(34);   % dx10/dt, dy10/dt
        dv1dt;
        du2dt; dv2dt;
        du3dt; dv3dt;
        du4dt; dv4dt;
        du5dt; dv5dt;
        du6dt; dv6dt;
        du8dt; dv8dt;
        du9dt; dv9dt;
        du10dt; dv10dt
    ];
endfunction
