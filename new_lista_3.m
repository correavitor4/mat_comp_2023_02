function new_lista_3()
  matrizCoeficientes = [0.780 ,0.563;
                        0.913 ,0.659];
  matrizConstantes = [0.217;
                      0.254];

  matrizPacialmentePivotada = executa_pivotamente_parcial (juntoAsDuasMatrizes(matrizCoeficientes, matrizConstantes))

  matrizTriangular = retornaTrianguloSuperior(matrizPacialmentePivotada);

  results = substit_regressiva(matrizTriangular)

endfunction

function x = retornaTrianguloSuperior(matriz)
  matrizDim = length(matriz(1, :)) - 1;
  for i = 1 : 1 : matrizDim - 1
    pivo = matriz(i, i);
    for j = i+1 : 1 : matrizDim
      fator = matriz(j ,i) / matriz(i, i);
      matriz(j, :) = matriz(j, :) - matriz(i, :) * fator;
    endfor
  endfor

  x = matriz;
endfunction

function x = juntoAsDuasMatrizes(matrizCoeficientes, matrizConstantes)
  x = horzcat(matrizCoeficientes, matrizConstantes);
endfunction

function x = executa_pivotamente_parcial (matriz)
  matrizDim = length(matriz(1, :)) - 1;
  for i = 1 : 1 : matrizDim
    [~, index] = max(abs(matriz(i:end, i)));
    linhaTemp = matriz(i, :);
    matriz(i, :) = matriz(index, :);
    matriz(index, :) = linhaTemp;
  endfor

  x = matriz;
endfunction

function x = substit_regressiva(matriz)
  matrizDim = length(matriz(1, :)) - 1;
  xValues = zeros(1, matrizDim);
  %Xn = An / Bn
  xValues(end) = matriz(end, end) / matriz(end, end -1);
  for i = matrizDim - 1 : -1 : 1
    xValues(i) = (matriz(i, end) - matriz(i, i + 1 : end -1) * xValues(i+1:end)')/matriz(i, i);
  endfor

  x = xValues;
endfunction
