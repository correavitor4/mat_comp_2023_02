function lista2()
  xi = [1; 1];
  maxIt = 10;
  tolerance = 10e-5;

  xIterations = zeros(2, maxIt); %Aqui fica x1 e x2
  fxIterations = zeros(2, maxIt); %Aqui fica f(x1) e f(x2)

  %Aqui são executadas as iterações
  for it = 1 : 1: maxIt
    %Retorno do metodo Newton-Raphson
    xi_plus_1 = xi - inv(fLinha(xi(1), xi(2)))*f(xi(1), xi(2));

    %Preenchimento dos vetores
    xIterations(:, it) = [xi_plus_1(1) xi_plus_1(2)];
    fxIterations(:, it) = [f(xi_plus_1(1), xi_plus_1(2))];

    if (max(abs(xi_plus_1 - xi)) <= tolerance)
      %Aqui os vetores são truncados
      xIterations = xIterations(:,1:it);
      fxIterations = fxIterations(:, 1:it);
      break;
    endif

    xi = xi_plus_1;
  endfor

  plota_graficos_convergencia(xIterations, fxIterations);

  plota_grafico_animado(xIterations, fxIterations)
endfunction

function y = f(x1, x2)
  y = zeros(2, 1);
  y(1) = f1(x1, x2);
  y(2) = f2(x1, x2);

endfunction

function y = f1(x1, x2)
  y = x1 + x2 - sqrt(x2) - 0.25;
endfunction

function y = f2(x1, x2)
  y = 8.*x1.^2 + 16.*x2 - 8.*x1.*x2 -10;
endfunction

function y = fLinha(x1, x2)
  y = [1, 1 - 1/(2*sqrt(x2)); 16.*x1 - 8.*x2, 16 - 8.*x1];
endfunction

function plota_graficos_convergencia(xIterations, fxIterations)
  nIteracoes = size(xIterations, 2);

  %Eixo x que será usado na plotagem dos 2 gráficos
  xValues = linspace(1, nIteracoes, nIteracoes);

  % Crie uma figura com uma largura maior para acomodar os subplots
  fig = figure(1);
  %set(fig, 'Position', [0, 0, 400, 800]); % Largura e altura aumentadas

  % Use subplot com uma matriz de layout para controlar a proporção horizontal
  % 2 linhas e 1 coluna (2 subplots na vertical)
  subplot(2, 1, 1);
  plot(xValues, xIterations(1, :), 'DisplayName', 'x1');
  hold on;
  plot(xValues, xIterations(2, :), 'DisplayName', 'x2');
  xlabel('Iterações', 'FontSize', 14);
  ylabel('valores de x1 e x2', 'FontSize', 12);
  legend('f(x1)', 'f(x2)');
  title('Gráfico de convergência em relação a x1 e x2', 'FontSize', 14);

  subplot(2, 1, 2);
  plot(xValues, fxIterations(1, :), 'DisplayName', 'f(x1)');
  hold on;
  plot(xValues, fxIterations(2, :), 'DisplayName', 'f(x2)');
  xlabel('Iterações', 'FontSize', 14);
  ylabel('valores de f(x1) e f(x2)', 'FontSize', 12);
  legend('f(x1)', 'f(x2)');
  title('Gráfico de convergência em relação a f(x1) e f(x2)', 'FontSize', 14);
endfunction

function plota_grafico_animado(xIterations, fxIterations)
  %Valores a serem plotados
  x1 = xIterations(1, :); %Valores de x1
  x2 = xIterations(2, :); %Valores de x2


  janela = figure(2); % Crie uma nova figura
  title('Gráficos Animados');


  %plotagem da primeira superfície
  subplot(1, 2, 1);
  xAxisValues = linspace(0 , 0.45, 100);
  yAxisValues = linspace(0.6 , 1.2, 100);
  [X1, X2] = meshgrid(xAxisValues, yAxisValues); %Grade para a plotagem
  Z1 = f1(X1, X2); %Valores de Z para a plotagem do segundo gráfico
  fig1 = surf(X1, X2, Z1); %plot da superfície
  t1 = title('');
  xlabel('eixo x1', 'FontSize', 14);
  ylabel('eixo x2', 'FontSize', 14);
  zlabel('f(x1, x2)', 'FontSize', 14);
  hold on;
  zlim([-0.5, 0.5]);
  bolinha1 = scatter3(x1(1), x2(2), f1(x1(1), x2(1)), 100, 'filled', 'r');
  hold off;


  %plotagem da segunda superfície
  subplot(1, 2, 2);
  xAxisValues = linspace(-1, 1.5, 100);
  yAxisValues = linspace(-1, 1.5, 100);
  [X1, X2] = meshgrid(xAxisValues, yAxisValues); %Grade para a plotagem
  Z2 = f2(X1, X2); %Valores de Z para a plotagem do segundo gráfico
  fig2 = surf(X1, X2, Z2);

  zlim([-2, 6]);
  t2 = title('');
  xlabel('eixo x1', 'FontSize', 14);
  ylabel('eixo x2', 'FontSize', 14);
  zlabel('f(x1, x2)', 'FontSize', 14);
  hold on;
  bolinha2 = scatter3(x1(1), x2(2), f2(x1(1), x2(1)), 100, 'filled', 'r');
  hold off;

  for i = 1 : length(x1)
    %atualize bolinha1
    newZ1Value = f1(x1(i), x2(i));
    set(bolinha1, 'xData', x1(i), 'yData', x2(i), 'zData', newZ1Value);
    set(t1, 'String', sprintf('F1(x1, x2)\n Iteração: %d', i));

    %atualize bolinha2
    newZ2Value = f2(x1(i), x2(i));
    set(bolinha2, 'xData', x1(i), 'yData', x2(i), 'zData', newZ2Value);
    set(t2, 'String', sprintf('F2(x1, x2)\n Iteração: %d', i));

    pause(1);
  endfor
endfunction
