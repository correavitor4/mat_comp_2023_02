function lista1()
  clc;
  xl = 1;
  xu = 1.5;
  tol = 10e-5;
  maxIt = 1000;

  if checkIfThereAreRootsInThisInterval(xl, xu) == 0
    printf("There is not roots in this interval")
    return
  endif

  bisection(xl, xu, tol, maxIt);

endfunction

function y = functionOfX(x)
  y = (x.^3) - (2.*(x.^2)) + x - 0.275;
endfunction

function response = checkIfThereAreRootsInThisInterval (xl, xu)
  if functionOfX(xl) * functionOfX(xu) < 0
    response = true;
    return
  endif

  response = false;
endfunction

function bisection(xl, xu, tol, maxIt);
  initialXu = xu;
  initialXl = xl;
  format long;
  oldxr = nan;
  for it = 1 : 1 : maxIt
    xr = (xl + xu)/2;

    plotGraphs(initialXl, initialXu, xr);

    toEvaluate = functionOfX(xl) * functionOfX(xr);
    if toEvaluate < 0
      xu = xr;

    elseif toEvaluate > 0
      xl = xr;

    else
      root = xr;
      printf("Root value: %f", root);
      return
    endif

    if abs(xr - oldxr) <= tol
      root = xr;
      printf("Root value: %f", root);
      return
    endif

    oldxr = xr;
  endfor

  printf("Cannot find root in less than %d iteratations", maxIt)
endfunction

function plotGraphs(initialXl, initialXu, xr)
  xlimFixValue = [initialXl initialXu];
  plotFunctionBetweenInterval(initialXl, initialXu);
  hold on;
  plot(xr, functionOfX(xr), 'o');
  xlim(xlimFixValue);
  pause(0.5);
  hold off;
endfunction

function plotFunctionBetweenInterval(x0, xf)
  xValues = linspace(x0, xf, 1000);
  yValues = functionOfX(xValues);
  plot(xValues, yValues);
endfunction

