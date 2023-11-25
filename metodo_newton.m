function metodo_newton()
  tol = 10e-3;
  x1 = x2 = ((4.5)/(5))*(pi);
  do_method(x1, x2, tol)
endfunction

function results = do_method(x1, x2, tol)
  xZero = [x1; x2];
  xNew = nan;
  results = zeros(3, 1000);

  for i=1 : 1000
    xNew = xZero - inv(hessiana(xZero)) * get_gradient_vector_result(xZero(1, 1), xZero(2, 1));

    results(1:2, i) = xNew;
    if abs(functionOfX(xNew)) <= tol
      results(3, i) = functionOfX(xNew);
      printf("Resultado encontrado em x1=%.16f, x2=%.16f e f(x1,x2)=%.16f  em %d iteracoes", xNew(1,1), xNew(2, 1), functionOfX(xNew), i);

      results = results(:, 1:i);
      return
    endif

    xZero = xNew;
  endfor

  printf("Resultado encontrado em x1=%.16f, x2=%.16f e f(x1,x2)=%.16f  em %d iteracoes", xNew(1,1), xNew(2, 1), functionOfX(xNew), 1000);
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

function res = hessiana(xValues)
  x1 = xValues(1, 1);
  x2 = xValues(2, 1);
  c = -((x1 - pi).^2 + (x2 - pi).^2);

  a1 = -exp(c);
  b1 = cos(x1);
  c1 = (-sin(x2) - 2.*cos(x2).*(x2- pi));
  a2 = exp(c);
  b2 = cos(x2);
  c2 = (sin(x1) + 2.*cos(x1)*(x1 - pi));

  des = -cos(x2) + 2.*(x2-pi).*(sin(x2) - cos(x2));
  des2 = cos(x1) - (2.*sin(x1).*(x1-pi) + 2.*cos(x1));

  res = [
    -2.*exp(c).*(x1 - pi).*b2.*c2 + a2.*b2.*des2,                           (-2.*exp(c).*(x2 - pi)).*b2.*c2 + a2.*(-sin(x2))*c2;
    -2.*exp(c).*(x1 - pi) .* cos(x1) .* (-sin(x2) - 2.*cos(x2).*(x2-pi)),   b1.*(-2.*exp(c).*(x2 - pi).*c1 + a1.*des)
  ];

endfunction
