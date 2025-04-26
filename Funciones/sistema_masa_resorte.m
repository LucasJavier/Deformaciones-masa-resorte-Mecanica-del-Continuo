function sistema_masa_resorte()
    clc; close all; clear;

    % Conexion de barras
    barras = [
        [1, 3]; [3, 2]; [2, 1]; [2, 7]; [7, 3]; [3, 8]; [8, 7];
        [4, 3]; [8, 4]; [4, 9]; [9, 8]; [5, 4]; [9, 5]; [5, 10];
        [10, 9]; [5, 6]; [6, 10];
    ];

    % Parámetros del sistema
    A = 0.1;                % Area barra
    rho = 1;                % Densidad de barra
    E = 120;                % Modulo de Young
    A_E = A * E;
    rho_A = rho * A;

    % Posiciones iniciales
    pos_inicial = [
        0, 0;   % Nodo 1 (fijo en x1)
        0, 10;  % Nodo 2
        10, 10;  % Nodo 3
        20, 10;  % Nodo 4
        30, 10;  % Nodo 5
        40, 10;  % Nodo 6
        0, 20; % Nodo 7 (fijo)
        10, 20; % Nodo 8
        20, 20; % Nodo 9
        30, 20  % Nodo 10
    ];

    m = calcular_masas(barras, pos_inicial, rho_A);
    kij = calcular_rigidez(barras, pos_inicial, A_E);

    % Vector de condiciones iniciales Y0 = [posiciones; velocidades]
    Y0 = [
        pos_inicial(1, 2);  % y1(0)
        pos_inicial(2, 1); pos_inicial(2, 2);  % x2(0), y2(0)
        pos_inicial(3, 1); pos_inicial(3, 2);  % x3(0), y3(0)
        pos_inicial(4, 1); pos_inicial(4, 2);  % x4(0), y4(0)
        pos_inicial(5, 1); pos_inicial(5, 2);  % x5(0), y5(0)
        pos_inicial(6, 1); pos_inicial(6, 2);  % x6(0), y6(0)
        pos_inicial(8, 1); pos_inicial(8, 2);  % x8(0), y8(0)
        pos_inicial(9, 1); pos_inicial(9, 2);  % x9(0), y9(0)
        pos_inicial(10, 1); pos_inicial(10, 2);% x10(0), y10(0)
        zeros(17, 1)                           % Velocidades iniciales = 0
    ];

    % Intervalo de tiempo
    tspan = [0, 50];

    % Resolvemos con ode45
    % Y: Matriz de soluciones de ode45 con posiciones y velocidades (Nx34)
    % t: Vector de tiempos correspondiente a las soluciones.
    % Sin sinusoidal P(t)
    opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
    [t_grandes, Y_grandes] = ode45(@(t,Y) f(t, Y, kij, pos_inicial, m, 1, 0, 0),...
                                             tspan, Y0, opts);
    [t_chicas, Y_chicas] = ode45(@(t,Y) f(t, Y, kij, pos_inicial, m, 0, 0, 0),...
                                             tspan, Y0, opts);

    % Calculamos las fuerzas en barra 'a' y posicion nodo 'b'
    [F_a_grandes, F_a_N_grandes, F_a_T_grandes, nodo_b_grandes] = calcular_fuerzas(Y_grandes, kij, pos_inicial, 1, A);
    [F_a_chicas, F_a_N_chica, F_a_T_chica, nodo_b_chicas] = calcular_fuerzas(Y_chicas, kij, pos_inicial, 0, A);

    % Grandes deformaciones, encontrar limite
    tF_grandes = encontrar_tF(t_grandes, Y_grandes, pos_inicial);
    tF_grandes_idx = find(t_grandes >= tF_grandes, 1); % Índice donde ocurre tF
                                 % 1: solo devuelve el 1ero que encuentra
    if isempty(tF_grandes_idx)
        tF_grandes_idx = length(t_grandes);
    endif

    % Pequeñas deformaciones, encontrar limite
    tF_chico = encontrar_tF(t_chicas, Y_chicas, pos_inicial);
    tF_chico_idx = find(t_chicas >= tF_chico, 1); % Índice donde ocurre tF
                                 % 1: solo devuelve el 1ero que encuentra
    if isempty(tF_chico_idx)
        tF_chico_idx = length(t_chicas);
    endif

    % Indice hasta el cual evaluamos en el tiempo
    tF_min = min(tF_grandes, tF_chico);
    [~, idx_g] = min(abs(t_grandes - tF_min));
    [~, idx_c] = min(abs(t_chicas - tF_min));

    % Posiciones iniciales (primeras 17 componentes de Y0)
    pos_inicial_flat = Y0(1:17)';

    % Encontramos la norma del vector desplazamiento maximo
    % Para grandes deformaciones
    [max_desp_g, t_max_g] = maximo_desplazamiento(idx_g,pos_inicial_flat,Y_grandes,t_grandes);
    % Para pequeñas deformaciones
    [max_desp_c, t_max_c] = maximo_desplazamiento(idx_c,pos_inicial_flat,Y_chicas,t_chicas);

    % Inciso e)
    frec = 5;
    opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 0.01);
    % Usamos ode15s, ya que es mas rapido para EDOs con sistemas rigidos.
    % ode45 requiere pasos pequeños para mantener la estabilidad en sistemas con escalas de tiempo
    % muy diferentes (rigidez). Por ejemplo, una carga de frecuencia de 100 Hz introduce una escala
    % de tiempo de ~0.01 segundos, forzando pasos aún más pequeños.
    % ode15s utiliza algoritmos implícitos adaptativos que manejan mejor la rigidez y permiten pasos
    % más grandes sin perder estabilidad.
    [t_sin, Y_sin] = ode15s(@(t,Y) f(t, Y, kij, pos_inicial, m, 1, 1, frec ),...
                                       tspan, Y0, opts);

    % Grandes deformaciones - P(t) = sin
    tF_sin = encontrar_tF(t_sin, Y_sin, pos_inicial);
    tF_sin_idx = find(t_sin >= tF_sin, 1); % Índice donde ocurre tF
                                 % 1: solo devuelve el 1ero que encuentra
    if isempty(tF_sin_idx)
        tF_sin_idx = length(t_sin);
    endif

    % Inciso a)-b)
    fprintf("tF para grandes deformaciones: %.3f.\n", tF_grandes);
    fprintf("tF para pequeñas deformaciones: %.3f.\n", tF_chico);
    % Inciso c)
    fprintf('Máxima norma de desplazamiento (grandes): %.4f m en t=%.3f s\n', max_desp_g, t_max_g);
    fprintf('Máxima norma de desplazamiento (pequeñas): %.4f m en t=%.3f s\n', max_desp_c, t_max_c);
    % Inciso e)
    fprintf("tF para grandes deformaciones - Carga sinusoidal: %.3f.\n", tF_sin);

    % Inciso d)
    % Graficas
    % Grandes deformaciones
    idx_grande = t_grandes <= tF_grandes;
    t_trunc_grande = t_grandes(idx_grande);
    Y_trunc_grande = Y_grandes(idx_grande, :);
    graficar_resultados(t_trunc_grande, Y_trunc_grande, pos_inicial, 1, 0, 0, 'Grandes deformaciones');
    % Pequeñas deformaciones
    idx_chica = t_chicas <= tF_chico;
    t_trunc_chica = t_chicas(idx_chica);
    Y_trunc_chica = Y_chicas(idx_chica, :);
    graficar_resultados(t_trunc_chica, Y_trunc_chica, pos_inicial, 3, 0, 0, 'Pequeñas deformaciones');
    % Grandes deformaciones - P(t) = sin)
    idx_sin = t_sin <= tF_sin;
    t_trunc_sin = t_sin(idx_sin);
    Y_trunc_sin = Y_sin(idx_sin, :);
    graficar_resultados(t_trunc_sin, Y_trunc_sin, pos_inicial, 5, 1, frec, 'Grandes deformaciones - Carga sinusoidal');
    % Graficar las tensiones
    graficar_tensiones(t_grandes, t_chicas, tF_grandes_idx, tF_chico_idx,...
                      F_a_grandes, F_a_chicas, nodo_b_grandes, nodo_b_chicas,...
                      F_a_N_grandes, F_a_N_chica, F_a_T_grandes, F_a_T_chica, 7);

    % Animaciones
    animar_estructura(Y_grandes, t_grandes, tF_grandes_idx, 10, 10, pos_inicial, barras, 'Grandes deformaciones');
    animar_estructura(Y_chicas, t_chicas, tF_chico_idx, 11, 10, pos_inicial, barras, 'Pequeñas deformaciones');
    animar_estructura(Y_sin, t_sin, tF_sin_idx, 12, 700, pos_inicial, barras, 'Grandes deformaciones - Carga sinusoidal');
endfunction
