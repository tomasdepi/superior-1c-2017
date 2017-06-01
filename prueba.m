pkg load signal
pkg load control

% crear la figura
f = figure ("position", [ 250 150 600 580 ]);

gp = uibuttongroup(f, "Position", [0 0 1 1])

metodoEntrada = uibuttongroup(gp, "Position", [0 0 1 1])

% test funcion de transferencia
tft = uicontrol (metodoEntrada, "style", "text", "string", "Ingrese funcion transferencia","position",[ 5 540 300 40 ], "horizontalalignment", "left");

rbtnPolinomios = uicontrol (metodoEntrada, "style", "radiobutton", "string", "Mediante Polinomios Numerador y Denominador", "Position", [ 10 520 300 20 ]);
rbtnPolosCeros = uicontrol (metodoEntrada, "style", "radiobutton", "string", "Mediante polos, ceros y ganancia", "Position", [ 10 500 300 20 ]);


% input funcion de transferencia
uicontrol(metodoEntrada, "style", "text", "string", "Pol. Numerador", "position", [5 450 110 30])
uicontrol(metodoEntrada, "style", "text", "string", "Pol. Denominador", "position", [280 450 120 30])
polNumerador = uicontrol (metodoEntrada, "style", "edit", "position",[120 450 150 30], "horizontalalignment", "left");
polDenominador = uicontrol (metodoEntrada, "style", "edit","position",[400 450 150 30], "horizontalalignment", "left");

uicontrol(metodoEntrada, "style", "text", "string", "Polos", "position", [5 410 100 30])
uicontrol(metodoEntrada, "style", "text", "string", "Ceros", "position", [220 410 100 30])
uicontrol(metodoEntrada, "style", "text", "string", "Ganancia", "position", [410 410 100 30])
ceros = uicontrol(metodoEntrada, "style", "edit", "position", [120 410 120 30], "horizontalalignment", "left")
polos = uicontrol(metodoEntrada, "style", "edit", "position", [300 410 120 30], "horizontalalignment", "left")
ganancia = uicontrol(metodoEntrada, "style", "edit", "position", [500 410 80 30], "horizontalalignment", "left")


% crear titulo
c1 = uicontrol (f, "style", "text", 
                "string", "Por favor, seleccione una opcion del menu:", 
                "position",[ 150 350 300 40 ]);

                
                
% crear los botones de funcionalidad


rbtnExpresion = uicontrol (gp, "style", "radiobutton",
                "string", "Obtener expresion de la funcion transferencia", 
                "Position", [ 40 310 300 20 ]);
rbtnIndicarPolos = uicontrol (gp, "style", "radiobutton", "string", "Indicar polos", 
                "position",[ 40 280 150 20 ] );
rbtnIndicarCeros = uicontrol (gp, "style", "radiobutton", "string", "Indicar ceros", 
                "position",[ 40 250 150 20 ]);
rbtnIndiciarGanancia = uicontrol (gp, "style", "radiobutton", "string", "Marcar ganancia", 
                "position",[ 40 220 150 20 ]);
rbtnExpresionPolosCeros = uicontrol (gp, "style", "radiobutton", "string", "Obtener expresion con sus polos, ceros y ganancia", 
                "position",[ 40 190 350 20 ]);
rbtnGrafico = uicontrol (gp, "style", "radiobutton", "string", "Mostrar graficamente la distribucion de polos y ceros", 
                "position",[ 40 160 350 20 ]);
rbtnEstabilidad = uicontrol (gp, "style", "radiobutton", "string", "Indicar estabilidad del sistema", 
                "position",[ 40 130 350 20 ]);
rbtnObtenerTodo = uicontrol (gp, "style", "radiobutton", "string", "Obtener todas las caracteristicas de la funcion transferencia", 
                "position",[ 40 130 360 20 ]);
                
                
% crear los botones de decisión
%b1 = uicontrol (f, "string", "Aceptar", "position",[50 20 100 40], {@myfunction, "1"});
b1 = uicontrol (f, "string", "Aceptar", "position",[120 50 100 40], "callback", "myfunction(inputValue)");
b3 = uicontrol (f, "string", "Finalizar", "position",[350 50 100 40], "callback", "close");

function myfunction(elem)
  
  b = get(elem, 'String'); 
  
  array = str2num([b]);
  
  % Pto: 1
  funcion = tf(array, [4 6 2]);
  t = evalc('funcion');
  fprintf("Funcion original: %s\n", t);
  [Zer, Pol, k] = tf2zp(array, [4 6 2]);
  
  % Mostrar polos y ceros y ganancia (ptos: 2, 3, 4)
  fprintf("Ceros: %f\n", Zer);
  fprintf("Polos: %f\n", Pol);
  fprintf("Ganancia: %f\n", k);
  
  % Pto: 5
  funcion2 = zpk(Zer, Pol, k);
  t2 = evalc('funcion2');
  fprintf("Funcion factorizada: %s", t2);
  
  % Mostrar graficamente los polos y ceros (pto: 6)
  f2 = figure ("position", [ 250 150 600 500 ]);
  pzmap(funcion);
  % polosCeros = tf2zp(funcion.num, funcion.den);
  
  % fprintf(polosCeros);
  %fprintf("%s", array);
  %pol = tf(b);
  %fprinf("%s", pol);
  % findobj("inputValue","string");
endfunction

% create an edit control
% e1 = uicontrol (f, "style", "edit", "string", "editable text", "position",[10 60 300 40]);
% p = uipanel ("title", "Panel Title", "position", [.25 .25 .5 .5]);
% add two buttons to the panel
% b1 = uicontrol ("parent", p, "string", "A Button", "position",[18 10 150 36]);
% b2 = uicontrol ("parent", p, "string", "Another Button", "position",[18 60 150 36]);
