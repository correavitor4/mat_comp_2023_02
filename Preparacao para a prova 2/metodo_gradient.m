function metodo_gradient()
  alfa = 2.09;
  tol = 10e-3;
  x1 = x2 = ((4.5)/(5))*(pi);

  results = do_method(x1, x2, alfa, tol);
  plot_graph(results);
endfunction

function results = do_method(x1, x2, alfa, tol)
  xZero = [
    x1;
    x2
  ];
  x1 = nan;
  results = zeros(3, 1000);

  for i=1 : 1000
    x1 = xZero - alfa * get_gradient_vector_result(xZero(1, 1), xZero(2, 1));

    results(1: 2, i) = x1;
    results(3, i) = functionOfX(x1);

    if(abs(functionOfX(x1)) <= tol)
      results = results(:, 1:i);

      printf("Raiz encontrada em x1=%.16f, x2=%.16f, z=%.16f  rodando %d iteracoes", x1(1,1), x1(2,1), functionOfX(x1), i);
      return;
    endif

    xZero = x1;
  endfor

  printf("Raiz encontrada em x1=%.16f, x2=%.16f, z=%.16f  rodando %d iteracoes", x1(1,1), x1(2,1), functionOfX(x1), 1000);

endfunction

function y = functionOfX(xValues)
  x1 = xValues(1,:);
  x2 = xValues(2,:);
  c = -((x1 - pi).^2 + (x2 - pi).^2);
  y = (-cos(x1)).*(cos(x2)).*exp(c);
endfunction

function y = functionOfXMesh(x1, x2)
  c = -((x1 - pi).^2 + (x2 - pi).^2);
  y = (-cos(x1)).*(cos(x2)).*exp(c);
endfunction

function response = get_gradient_vector_result(x1, x2)
  c = -((x1 - pi).^2 + (x2 - pi).^2);
  response = [
    exp(c).*cos(x2).*(sin(x1) + 2.*cos(x1).*(x1 - pi));
    (-exp(c)).*cos(x1).*((-sin(x2)) -2.*cos(x2).*(x2 - pi))
  ];
endfunction

function plot_graph(results)
  x1Values = 1 : 0.2 : 5;
  x2Values = 1 : 0.2 : 5;
  [x1Values x2Values] = meshgrid(x1Values, x2Values);
  zValues = functionOfXMesh(x1Values, x2Values);

  %plot surface
  surf(x1Values, x2Values, zValues);
  hold on;

  for i=1 : length(results(1,:))

    scatter3(results(1, i), results(2, i), results(3, i), 'MarkerFaceColor', 'r', 'sizedata', 100);

    if (i>1)
      x1Interval = results(1, i-1 : i);
      x2Interval = results(2, i-1 : i);
      zInterval = results(3, i-1 : i);
      plot3(x1Interval, x2Interval, zInterval);
    endif
    %pause(0.7);
  endfor
endfunction
