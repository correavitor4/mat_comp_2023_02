function false_position()
  clc;
  x1 = 0;
  x2 = 1;
  tol = 10e-5;
  maxIt = 1000;

  res = start_process(x1, x2, tol, maxIt);

  plot_gaph(res);

endfunction

function y = fX(x)
  y = x.^3 + 2.*x.^2 -2;
endfunction

function results = start_process(x1, x2, tol, maxIt)
  results = zeros(3, maxIt);
  oldXm = nan;

  for i=1 : 1 : maxIt
    xm = x2 - ((fX(x2)*(x1 - x2))/(fX(x1) - fX(x2)));
    results(:, i) = [x1;
                     x2;
                     xm];

    if (abs(xm - oldXm) <= tol)
      printf('Raiz encontrada: %.16f\num iteracoes: %d', xm, i);
      results = results(:, 1:i);
      return;
    endif

    if fX(x1) * fX(x2) < 0
      x2 = xm;
    elseif fX(x1) * fX(x2) > 0
      x1 = xm;
    else
      results = results(:, 1:i);
      printf('Raiz encontrada: %.16f\num iteracoes: %d', xm, i);
      return;
    endif

    oldXm = xm;
  endfor
endfunction

function plot_gaph(res)
  xValues = linspace(-.8, 1.6, 100);
  for i = 1 : 1 : length(res)
    hold off;
    plot(xValues, fX(xValues));
    hold on;
    s1 = scatter(res(1, i), fX(res(1, i)), "MarkerFaceColor", "r");
    s2 = scatter(res(2, i), fX(res(2, i)), "MarkerFaceColor", "g");
    s3 = scatter(res(3, i), fX(res(3, i)), "MarkerFaceColor", "b");
    plot([res(1, i), res(2, i)],[fX(res(1, i)), fX(res(2, i))]);
    legend("curva", "f(x1)", "f(x2)", "f(xm)", "reta de x1 a x2");
    str = ['Gráfico de falsa posição. iteração: ',num2str(i)];
    title(str, 'fontsize', 20);
    grid on;
    pause(1);
  endfor
endfunction
