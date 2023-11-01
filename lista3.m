function lista3()

  mainMatrix = [2 0 1 2 ; 5 -1 1 5; -1 2 2 0];

  mainMatrix = progressiveElimination(mainMatrix);

  xValues = extractXValues(mainMatrix);

  printResults(xValues);

endfunction

% Primeiro passo
function x = progressiveElimination(matrix)
  matrixDimension = length(matrix(1, :)) - 1;
  for i = 1 : 1 : matrixDimension;
    pivot = matrix(i, i);
    for j = (i + 1) : 1 : matrixDimension
      factor = matrix(j, i) / matrix(i, i);
      matrix(j, :) = matrix(j, :) - matrix(i , :) * factor;
    endfor
  endfor

  x = matrix;
endfunction

function xValues = extractXValues(matrix)
  matrixDimension = length(matrix(1, :)) - 1;
  xValues = zeros(1, matrixDimension);

  for i = matrixDimension : -1 : 1
    if i == matrixDimension
      xValues(i) = matrix(i, i+1);
      continue;
    endif
    xValues(i) = (matrix(i, end) - xValues(i+1: end) * matrix(i+1, end - 1)) / matrix(i, i);
  endfor
endfunction

function printResults(xValues)
  printf('Resultados: \n');
  for i = 1 : 1 : length(xValues)
    printf('x%d: %.16f', i ,xValues(i));
  endfor

endfunction
