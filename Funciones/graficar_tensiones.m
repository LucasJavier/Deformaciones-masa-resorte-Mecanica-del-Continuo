function graficar_tensiones(t_g, t_c, tf_g_idx, tf_c_idx, F_a_g, F_a_c, nb_g, nb_c,...
                            F_N_g, F_N_c, F_T_g, F_T_c, figure_idx)
  nb_gx = nb_g(:,1);
  nb_gy = nb_g(:,2);
  nb_cx = nb_c(:,1);
  nb_cy = nb_c(:,2);

  figure(figure_idx, 'Name', 'Fuerzas');
  plot(t_g(1:tf_g_idx), F_a_g(1:tf_g_idx), 'b-', 'LineWidth', 1.5);
  hold on;
  plot(t_c(1:tf_c_idx), F_a_c(1:tf_c_idx), 'r-', 'LineWidth', 1.5);
  xlabel('Tiempo (s)');
  ylabel('Tensiónes');
  legend('Grandes deformaciones', 'Pequeñas deformaciones');
  title('Evolución de la tensión en la barra a');
  grid on;
  pause(2)

  figure(figure_idx+1, 'Name', 'Fuerzas normales y tangenciales')
  plot(t_g(1:tf_g_idx), F_N_g(1:tf_g_idx), 'b-', 'LineWidth', 1.5);
  hold on;
  plot(t_c(1:tf_c_idx), F_N_c(1:tf_c_idx), 'r-', 'LineWidth', 1.5);
  plot(t_g(1:tf_g_idx), F_T_g(1:tf_g_idx), 'k-', 'LineWidth', 1.5);
  plot(t_c(1:tf_c_idx), F_T_c(1:tf_c_idx), 'y-', 'LineWidth', 1.5);
  xlabel('Tiempo (s)');
  ylabel('Tensiónes normales y tangenciales');
  legend('Grandes deformaciones - Normal', 'Pequeñas deformaciones - Normal',...
         'Grandes deformaciones - Tangencial', 'Pequeñas deformaciones - Tangencial');
  title('Evolución de la tensión normal y tangenciales en la barra a');
  grid on;
  pause(2)

  figure(figure_idx+2, 'Name', 'Movimiento nodo 6');
  subplot(2,1,1);
  plot(t_g(1:tf_g_idx), nb_gx(1:tf_g_idx), 'b-', 'LineWidth', 1.5);
  hold on;
  plot(t_c(1:tf_c_idx), nb_cx(1:tf_c_idx), 'r-', 'LineWidth', 1.5);
  ylabel('Posición X (m)');
  legend('Grandes deformaciones', 'Pequeñas deformaciones');
  title('Coordenada X del nodo 6');
  grid on;

  subplot(2,1,2);
  plot(t_g(1:tf_g_idx), nb_gy(1:tf_g_idx), 'b-', 'LineWidth', 1.5);
  hold on;
  plot(t_c(1:tf_c_idx), nb_cy(1:tf_c_idx), 'r-', 'LineWidth', 1.5);
  xlabel('Tiempo (s)');
  ylabel('Posición Y (m)');
  legend('Grandes deformaciones', 'Pequeñas deformaciones');
  title('Coordenada Y del nodo 6');
  grid on;
  pause(2)
endfunction
