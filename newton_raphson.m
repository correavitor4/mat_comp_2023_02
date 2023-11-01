function newton_raphson();
  x1 = 1;
  x2 = 1;
  maxIt = 1000;
  tol = 10e-5;

  start_newton_raphson(x1, x2, maxIt, tol)

endfunction

function y = fX1(x1, x2)
  y = x1 + x2 - sqrt(x2) - 0.25;
endfunction

function y = fX2(x1, x2)
  y = 8.*x1.^2 + 16.*x2 - 8.*x1.*x2 -10;
endfunction

function start_newton_raphson(x1, x2, maxIt, tol)

  xRes = zeros(2, maxIt);

  xi = [x1;
        x2];

  for i=1 : 1 : maxIt
    newXi = xi - inv(jacobiana(xi(1, 1), xi(2, 1))) * f(xi(1, 1), xi(2, 1));

    xRes(:, i) = [newXi(1, 1), newXi(2, 1)];

    if max(abs(newXi - xi)) <= tol
      printf('Resultado encontrado: [%.16f, %.16f]com %d iteracoes.', newXi(1, 1), newXi(2, 1), i);
      xRes = xRes(:, 1:i);

      plot_graficos_convergencia(xRes);
      return;
    endif

    xi = newXi;
  endfor

endfunction

function plot_graficos_convergencia(xRes)
  f1 = figure(1);

  subplot(2, 1, 1);
  plot([1 length(xRes(1,:))],[xRes(1,1) xRes(1,end)]);
  hold on;
  plot([2 length(xRes(2,:))], xRes(1, :));
  hold on;
endfunction

function y = f(x1, x2)
  y = [fX1(x1, x2);
       fX2(x1, x2)];
endfunction

function y = jacobiana(x1, x2)
  f1LinhaX1 = 1;
  f1LinhaX2 = 1 - (2.*sqrt(x2)).^(-1);
  f2LinhaX1 = 16.*x1 - 8.*x2;
  f2LinhaX2 = 16 - 8.*x1;

  y = y = [1, 1 - 1/(2*sqrt(x2)); 16.*x1 - 8.*x2, 16 - 8.*x1];
endfunction
