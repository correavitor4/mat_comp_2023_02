function lista5()
  order = 4;
  points = [
    3 4 5 7 8 9 11 12;
    1.6 3.6 4.4 3.4 2.2 2.8 3.8 4.6
  ];

  polynomial_reg(points, order);
endfunction

function polynomial_reg(points, order)
  xVector = points(1, :);
  yVector = points(2, :);
  n = length(xVector);
  m = order + 1;

  extendedMatrix = zeros(m, m+1);

  for i=1 : m
    for j=1 : i
      k = i + j - 2;

      currentSum = 0;
      for l=1 : n
        currentSum = currentSum + xVector(l)^k;
      endfor
      extendedMatrix(i, j) = currentSum;
      extendedMatrix(j, i) = currentSum;
    endfor

    currentSum = 0;
    for l=1 : n
      currentSum = currentSum + yVector(l)* (xVector(l)^(i-1));
    endfor
    extendedMatrix(i, order+2) = currentSum;
  endfor

  coefs = get_coeficients(extendedMatrix);

  plotPoints(points);
  plotFunc(coefs, points(1, 1) - 2, points(1, end) + 2, 0.1);

endfunction

function coefs = get_coeficients(matrix)
  A = matrix(:, 1 : end - 1);
  b = matrix(:, end);

  coefs = A\b;
endfunction

function plotFunc(coefs, xMin, xMax, step)
  xValues = xMin : step : xMax;
  yValues = zeros(1, length(xValues));

  for i=1: 1: length(xValues)
    yValues(i) = functionOfX(coefs, xValues(i));
  endfor

  plot(xValues, yValues);

endfunction

function y = functionOfX(coefs, x)
  currentSum = 0;
  for i=1: length(coefs)
    currentSum = currentSum + coefs(i)*(x^(i-1));
  endfor

  y = currentSum;
endfunction

function plotPoints(points)
  for i=1: 1: length(points(1, :))
    currentPoint = points(:, i);
    x = currentPoint(1, 1);
    y = currentPoint(2, 1);

    scatter(x, y, 'filled', 'MarkerFaceColor', [0.5 , 0.5, 0.5]);
    hold on;
  endfor
endfunction
