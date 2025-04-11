function kij = calcular_rigidez(barras, pos_actual, A_E)
  kij = zeros(size(barras, 1), 1);
  for barra = 1:size(barras, 1)
      i = barras(barra, 1);
      j = barras(barra, 2);
      L0 = norm(pos_actual(j,:) - pos_actual(i,:));
      kij(barra) = A_E / L0;
  endfor
endfunction
