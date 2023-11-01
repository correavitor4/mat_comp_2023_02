function gauss_jordan()
  matrizCoef = [2 0 1;
                5 -1 1;
                -1 2 2];
  matrizConst = [2;
                 5;
                 0];

  matriz = horzcat(matrizCoef, matrizConst);

  matriz = pivot_parcial(matriz);

  resultados = exec_gauss_jordan(matriz)
endfunction

function x = pivot_parcial(matriz)
  dim = getMatDim(matriz);
  for i = 1 : 1 : dim
    [~, pos] = max(abs(matriz(i:end, i)));
    pos = pos + i - 1;
    if pos == i
      continue;
    endif

    temp = matriz(i, :);
    matriz(i, :) = matriz(pos, :);
    matriz(pos, :) = temp;
  endfor

  x = matriz;
endfunction

function x = getMatDim(matriz)
  x = length(matriz(1, :)) -1;
endfunction

function resultados = exec_gauss_jordan(matriz)
  matDim = getMatDim(matriz);
  %for que que zera os elementos que estão abaixo da diag principal
  for i = 1 : 1 : matDim
    %normaliza
    matriz(i, :) = matriz(i, :) ./ matriz(i, i);

    for j = i+1 : 1 : matDim
      fator = matriz(j, i) / matriz(i, i);
      matriz(j, :) = matriz(j, :) - matriz(i, :) * fator;
    endfor
  endfor

  %for que elimina os elementos que estão acima da diag principal
  for i = matDim : -1 : 1
    for j = i-1 : -1 : 1
      fator = matriz(j, i) / matriz(i, i);
      matriz(j, :) = matriz(j, :) - matriz(i, :) * fator;
    endfor
  endfor

  resultados = zeros(1, matDim);
  for i = 1 : 1 : matDim
    resultados(1, i) = matriz(i, end);
  endfor
endfunction
