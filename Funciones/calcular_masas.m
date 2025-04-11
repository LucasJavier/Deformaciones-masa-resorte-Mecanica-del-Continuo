function m = calcular_masas(barras, pos_inicial, rho_A)
  m = zeros(10, 1);
  for barra = 1:size(barras, 1)
      i = barras(barra, 1);
      j = barras(barra, 2);
      L0 = norm(pos_inicial(j,:) - pos_inicial(i,:));
      m_barra = rho_A * L0;
      m(i) = m(i) + m_barra / 2;
      m(j) = m(j) + m_barra / 2;
  endfor
endfunction
