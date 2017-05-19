% crear la figura
f = figure ("position", [ 250 150 600 500 ]);
% crear el grupo de botones
gp = uibuttongroup (f, "Position", [ 0 0 1 1 ]);
% test funcion de transferencia
tft = uicontrol (gp, "style", "text", "string", "Ingrese funcion transferencia","position",[ 5 450 300 40 ], "horizontalalignment", "left");
% input funcion de transferencia
inputValue = uicontrol (gp, "style", "edit", "string", "","position",[ 5 400 300 40 ], "horizontalalignment", "left");
% crear título
c1 = uicontrol (gp, "style", "text", 
                "string", "Por favor, seleccione una opción del menú", 
                "position",[ 100 350 300 40 ]);
% crear los botones de funcionalidad
r1 = uicontrol (gp, "style", "radiobutton",
                "string", "Obtener expresión de la función transferencia", 
                "Position", [ 10 310 300 20 ]);
r2 = uicontrol (gp, "style", "radiobutton",
                "string", "Obtener características de la función", 
                "Position", [ 10 280 300 20 ]);
c1 = uicontrol (gp, "style", "checkbox", "string", "Indicar polos", 
                "position",[ 40 250 150 20 ] );
c2 = uicontrol (gp, "style", "checkbox", "string", "Indicar ceros", 
                "position",[ 40 220 150 20 ]);
c3 = uicontrol (gp, "style", "checkbox", "string", "Marcar ganancia", 
                "position",[ 40 190 150 20 ]);
c4 = uicontrol (gp, "style", "checkbox", "string", "Obtener expresión con sus polos, ceros y ganancia", 
                "position",[ 40 160 350 20 ]);
c5 = uicontrol (gp, "style", "checkbox", "string", "Mostrar gráficamente la distribució de polos y ceros", 
                "position",[ 40 130 350 20 ]);
c6 = uicontrol (gp, "style", "checkbox", "string", "Indicar estabilidad del sistema", 
                "position",[ 40 100 350 20 ]);
% crear los botones de decisión
%b1 = uicontrol (f, "string", "Aceptar", "position",[50 20 100 40], {@myfunction, "1"});
b1 = uicontrol (f, "string", "Aceptar", "position",[50 20 100 40], "callback", "myfunction(inputValue)");
b2 = uicontrol (f, "string", "Ingresar nueva función", "position",[168 20 150 40]);
b3 = uicontrol (f, "string", "Finalizar", "position",[335 20 100 40], "callback", "close");

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
