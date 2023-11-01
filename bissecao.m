function bissecao()
  x1 = 1;
  x2 = 1.5;
  tol = 10e-5;
  maxIt = 1000;

  res = iniciar_its(x1, x2, tol, maxIt);

  plotRes(res);

endfunction

function resultsX = iniciar_its(x1, x2, tol, maxIt)
  resultsX = zeros(3, maxIt);
  oldXm = nan;

  for i = 1 : 1 : maxIt
    xm = get_ponto_medio(x1, x2);

    resultsX(:, i) = [x1;
                      x2;
                      xm];

    if function_of_x(x2) * function_of_x(xm) < 0
      x1 = xm;

    elseif function_of_x(x2) * function_of_x(xm) > 0
      x2 = xm;

    else
      printf('root value: %.16f\n num iteracoes: %d', xm, i);
      resultsX = resultsX(:, 1:i);
      return
    endif

    toEval = abs(xm - oldXm);
    if toEval <= tol
      resultsX = resultsX(:, 1:i);
      printf('root value: %.16f\n num iteracoes: %d', xm, i);
      return
    endif

    oldXm = xm;
  endfor

endfunction

function plotRes(xRes)

  a = length(xRes(1, :));

  %loop que atualiza os pontos
  for i = 1 : 1 : a
    hold off;
    xLineValues = linspace(1, 1.7, 100);
    plot(xLineValues, function_of_x(xLineValues));
    hold on;

    scX1 = scatter(xRes(1, i), function_of_x(xRes(1, i)), 'MarkerFaceColor', 'b');
    scX2 = scatter(xRes(2, i), function_of_x(xRes(2, i)), 'MarkerFaceColor', 'g');
    scX3 = scatter(xRes(3, i), function_of_x(xRes(3, i)), 'MarkerFaceColor', 'm');

    legend('funcao', 'x1', 'x2', 'xm');
    titStr = ['bissação\n Iteracao:', num2str(i)];
    title(titStr);

    pause(0.5);

  endfor

endfunction

function y = function_of_x(x)
  y = x.^3 - 2.*x.^2 + x -0.275;
endfunction

function pm = get_ponto_medio(x1, x2)
  pm = (x1 + x2)/2;
endfunction
