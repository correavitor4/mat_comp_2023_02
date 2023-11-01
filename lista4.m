function lista4()
  clc;
  maxIt = 1000;
  tol = 10e-3;
  xInit = transpose([0 2]);
  alfa = 0.08;

  resGradient = gradient(xInit, maxIt, tol, alfa);
  resNewton = newton_method(xInit, maxIt, tol);

  plotGradient(resGradient);
  plot_newton_method(resNewton);

endfunction

function values = gradient (xInit, maxIt, tol, alfa)
  values = zeros(3, 1000);
  x0 = xInit;
  x1 = nan;

  for i=1: 1: 1000
    x1 = x0 - alfa .* (get_gradient(x0));
    x0 = x1;
    fxRes = fx(x1);
    values(:, i) = [x1(1, 1); x1(2, 1); fxRes];

    if (abs(fxRes) <= tol)
      values = values(:, 1:i);
      break;
    endif
  endfor

endfunction

function y = fx(xValues)
  x1 = xValues(1, :);
  x2 = xValues(2, :);

  y = (2.*x1 + x2 -5).^2 + (x1 + 2.*x2 -7).^2;
endfunction

function grad = get_gradient(xValues)
  x1 = xValues(1, 1);
  x2 = xValues(2, 1);

  grad = [
    4.*(2.*x1 + x2 - 5) + 2.*(x1 + 2.*x2 -7);
    2.*(2.*x1 + x2 - 5) + 4.*(x1 + 2.*x2 -7)
  ];
endfunction

function h = hessiana(xValues)
  x1 = xValues(1, 1);
  x2 = xValues(2, 1);

  h = [
    10, 8;
    8, 10
  ];
endfunction

function values = newton_method(xInit, maxIt, tol)
   values = zeros(3, 1000);
   x0 = xInit;
   x1 = nan;

   for i=1: 1: maxIt
     x1 = x0 - inv(hessiana(x0)) * get_gradient(x0);
     x0 = x1;
     fxRes = fx(x1);
     values(:, i) = [x1(1, 1); x1(2, 1); fxRes];

     if (abs(fxRes) <= tol)
       values = values(:, 1:i);
       break;
     endif
   endfor

endfunction

function plotGradient(res)
  x1 = res(1, :);
  x2 = res(2, :);
  fxRes = res(3, :);

  %define a figura
  fig = figure(1);
  set(fig, 'Name', 'Metodo Gradiente');

  %plot do gráfico de convergencia
  subplot(3, 2, 1);
  plot([1: length(x1)], x1);
  hold on;
  plot([1: length(x2)], x2)
  legend('x1', 'x2');
  title('Grafico de convergencia de x1 e x2');

  subplot(3, 2, 2);
  resFx = fx([x1; x2]);
  plot([1: length(x1)], resFx);
  legend('f(x1, x2)');
  title('Grafico de convergencia de f(x1, x2)');

  %plot do gráfico de pontos
  subplot(3,2, 3:6);
  %plota o gráfico
  [x1, x2] = meshgrid(0.5: 0.1: 1.5, 2.5: 0.1: 4);
  z = (2.*x1 + x2 -5).^2 + (x1 + 2.*x2 -7).^2;
  surf(x1, x2, z);

  x1 = res(1, :);
  x2 = res(2, :);
  fxRes = res(3, :);

  %nomeia os eixos
  xlabel('Eixo X1');
  ylabel('Eixo X2');
  zlabel('Eixo F(X1, X2)');
  hold on;

  for i=1: 1 : length(x1)
    %Atualiza o título
    titleStr = sprintf('Grafico da funcao com pontos sendo plotados dinamicamente. Iteracao atual: %d', i);
    title(titleStr, 'fontsize', 12);

    scatter3(x1(i), x2(i), fxRes(i), 70, 'filled');

    if i > 1
      plot3([x1(i-1), x1(i)], [x2(i-1), x2(i)], [fxRes(i-1), fxRes(i)], 'r-', 'LineWidth', 3);
    endif

    pause(1.25);
  endfor
endfunction

function plot_newton_method(res)
  x1 = res(1, :);
  x2 = res(2, :);
  fxRes = res(3, :);

  %define a figura
  fig = figure(2);
  set(fig, 'Name', 'Metodo de newton');

  %plot do gráfico de convergencia
  subplot(3, 2, 1);
  scatter(1, x1);
  hold on;
  scatter(1, x2);
  legend('x1', 'x2');
  title('Grafico de convergencia de x1 e x2');

  subplot(3, 2, 2);
  resFx = fx([x1; x2]);
  scatter(1, resFx);
  legend('f(x1, x2)');
  title('Grafico de convergencia de f(x1, x2)');

  %plot do gráfico de pontos
  subplot(3,2, 3:6);
  %plota o gráfico
  [x1, x2] = meshgrid(0.5: 0.1: 1.5, 2.5: 0.1: 4);
  z = (2.*x1 + x2 -5).^2 + (x1 + 2.*x2 -7).^2;
  surf(x1, x2, z);

  x1 = res(1, :);
  x2 = res(2, :);
  fxRes = res(3, :);

  %nomeia os eixos
  xlabel('Eixo X1');
  ylabel('Eixo X2');
  zlabel('Eixo F(X1, X2)');
  hold on;

  for i=1: 1 : length(x1)
    %Atualiza o título
    titleStr = sprintf('Grafico da funcao com pontos sendo plotados dinamicamente. Iteracao atual: %d', i);
    title(titleStr, 'fontsize', 12);

    scatter3(x1(i), x2(i), fxRes(i), 70, 'filled');

    if i > 1
      plot3([x1(i-1), x1(i)], [x2(i-1), x2(i)], [fxRes(i-1), fxRes(i)], 'r-', 'LineWidth', 3);
    endif

    pause(1.25);
  endfor
endfunction
