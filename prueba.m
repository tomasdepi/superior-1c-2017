pkg load signal
pkg load control

% crear la figura
f = figure ("position", [ 250 150 600 580 ]);

gp = uibuttongroup(f, "Position", [0 0 1 1])

metodoEntrada = uibuttongroup(gp, "Position", [0 0 1 1])
metodoEntradaPolinomios = uibuttongroup(metodoEntrada, "Position", [0 0 1 1])
metodoEntradaCerosPolos = uibuttongroup(metodoEntrada, "Position", [0 0 1 1])

% test funcion de transferencia
tft = uicontrol (metodoEntrada, "style", "text", "string", "Ingrese funcion transferencia","position",[ 5 540 300 40 ], "horizontalalignment", "left");

rbtnPolinomios = uicontrol (metodoEntrada, "style", "radiobutton", "string", "Mediante Polinomios Numerador y Denominador", "Position", [ 10 520 300 20 ], "callback", "myRadioButtonCallback(metodoEntradaCerosPolos, metodoEntradaPolinomios)");
rbtnPolosCeros = uicontrol (metodoEntrada, "style", "radiobutton", "string", "Mediante polos, ceros y ganancia", "Position", [ 10 500 300 20 ], "callback", "myRadioButtonCallback(metodoEntradaPolinomios, metodoEntradaCerosPolos)","value", 1);


% input funcion por polinomios
uicontrol(metodoEntradaPolinomios, "style", "text", "string", "Pol. Numerador", "position", [5 450 110 30])
uicontrol(metodoEntradaPolinomios, "style", "text", "string", "Pol. Denominador", "position", [280 450 120 30])
polNumerador = uicontrol (metodoEntradaPolinomios, "style", "edit", "position",[120 450 150 30], "horizontalalignment", "left");
polDenominador = uicontrol (metodoEntradaPolinomios, "style", "edit","position",[400 450 150 30], "horizontalalignment", "left");

% input funcion por polos y ceros
uicontrol(metodoEntradaCerosPolos, "style", "text", "string", "Ceros", "position", [5 410 100 30])
uicontrol(metodoEntradaCerosPolos, "style", "text", "string", "Polos", "position", [220 410 100 30])
uicontrol(metodoEntradaCerosPolos, "style", "text", "string", "Ganancia", "position", [410 410 100 30])
ceros = uicontrol(metodoEntradaCerosPolos, "style", "edit", "position", [120 410 120 30], "horizontalalignment", "left")
polos = uicontrol(metodoEntradaCerosPolos, "style", "edit", "position", [300 410 120 30], "horizontalalignment", "left")
ganancia = uicontrol(metodoEntradaCerosPolos, "style", "edit", "position", [500 410 80 30], "horizontalalignment", "left")


% crear titulo
c1 = uicontrol (f, "style", "text", 
                "string", "Por favor, seleccione una opcion del menu:", 
                "position",[ 150 350 300 40 ]);
               
                
% crear los botones de funcionalidad
opcion = uicontrol (gp, "style", "text", "string", "LTA", "position",[ 1 1 1 1 ], "value", 1);
rbtnExpresion = uicontrol (gp, "style", "radiobutton",
                "string", "Obtener expresion de la funcion transferencia", 
                "Position", [ 40 310 300 20 ], "callback", "setRetorno(1, opcion)", "value", 1);
rbtnIndicarPolos = uicontrol (gp, "style", "radiobutton", "string", "Indicar polos", 
                "position",[ 40 280 150 20 ], "callback", "setRetorno(2, opcion)");
rbtnIndicarCeros = uicontrol (gp, "style", "radiobutton", "string", "Indicar ceros", 
                "position",[ 40 250 150 20 ], "callback", "setRetorno(3, opcion)");
rbtnIndiciarGanancia = uicontrol (gp, "style", "radiobutton", "string", "Marcar ganancia", 
                "position",[ 40 220 150 20 ], "callback", "setRetorno(4, opcion)");
rbtnExpresionPolosCeros = uicontrol (gp, "style", "radiobutton", "string", "Obtener expresion con sus polos, ceros y ganancia", 
                "position",[ 40 190 350 20 ], "callback", "setRetorno(5, opcion)");
rbtnGrafico = uicontrol (gp, "style", "radiobutton", "string", "Mostrar graficamente la distribucion de polos y ceros", 
                "position",[ 40 160 350 20 ], "callback", "setRetorno(6, opcion)");
rbtnEstabilidad = uicontrol (gp, "style", "radiobutton", "string", "Indicar estabilidad del sistema", 
                "position",[ 40 130 350 20 ], "callback", "setRetorno(7, opcion)");
rbtnObtenerTodo = uicontrol (gp, "style", "radiobutton", "string", "Obtener todas las caracteristicas de la funcion transferencia", 
                "position",[ 40 100 360 20 ], "callback", "setRetorno(8, opcion)");
                
                
% crear los botones de decisión
b1 = uicontrol (metodoEntradaPolinomios, "string", "Aceptar", "position",[120 50 100 40], "callback", "procesarPorNumeradorDenominador(polNumerador, polDenominador, opcion)");
b2 = uicontrol (metodoEntradaCerosPolos, "string", "Aceptar", "position",[120 50 100 40], "callback", "procesarPorCeroPolosGanancia(ceros, polos, ganancia, opcion)");
b3 = uicontrol (f, "string", "Finalizar", "position",[350 50 100 40], "callback", "close");

function setRetorno(val, variable)  
  set(variable, "value", val);
endfunction

function myRadioButtonCallback(controlDown, controlUp)
  setVisibility(controlDown, "off");    
  setVisibility(controlUp, "on");   
endfunction

function setVisibility(control, value)  
  set(control, "visible", value);
endfunction

function procesarPorNumeradorDenominador(polNumerador, polDenominador, opcion)
  valPolNumerador = get(polNumerador, 'String'); 
  valPolDenominador = get(polDenominador, 'String'); 
     
  funcion = tf(str2num([valPolNumerador]),str2num([valPolDenominador]));
  [Zer, Pol, k] = tf2zp(str2num([valPolNumerador]),str2num([valPolDenominador]));
   
  % Factorizar Tranferencia
  sCeros = sort(Zer);
  sPolos = sort(Pol);
  nCeros = [];
  nPolos = [];
  index = 1;
   
  for i = 1:length(sPolos)    
    if (length(sCeros) >= index)
      if (sCeros(index) != sPolos(index))        
          nCeros = [nCeros sCeros(index)];
        nPolos = [nPolos sPolos(index)];      
      endif
    else      
      nPolos = [nPolos sPolos(index)];
    endif
    index++;
  endfor
    
  funcion2 = zpk(nCeros, nPolos, k);
  
  showResult(get(opcion,"value"), funcion, nCeros, nPolos, k, funcion2);      
     
endfunction

function procesarPorCeroPolosGanancia(ceros, polos, ganancia, opcion)
  valCeros = get(ceros, 'String'); 
  valPolos = get(polos, 'String'); 
  valGanancia = get(ganancia, 'String'); 
   
  % Factorizar Tranferencia
  sCeros = sort(str2num([valCeros]));
  sPolos = sort(str2num([valPolos]));
  nCeros = [];
  nPolos = [];
  index = 1;
   
  for i = 1:length(sPolos)    
    if (length(sCeros) >= index)
      if (sCeros(index) != sPolos(index))        
        nCeros = [nCeros sCeros(index)];
        nPolos = [nPolos sPolos(index)];      
      endif
    else      
      nPolos = [nPolos sPolos(index)];
    endif
    index++;
  endfor
  
  functionByPolosCerosOriginal = zpk(sCeros, sPolos, str2num(valGanancia)); 
  functionByPolosCeros = zpk(nCeros, nPolos, str2num(valGanancia)); 
  [Zer, Pol, k] = tf2zp(functionByPolosCeros.num,functionByPolosCeros.den);
       
  showResult(get(opcion,"value"), functionByPolosCerosOriginal, Zer, Pol, k, functionByPolosCeros);
  
endfunction

function showResult(opcion, funcionTransfOriginal, Zer, Pol, k, funcionTransfFact)
  % f3 = figure ("position", [ 250 150 600 500 ]);
  % results = uibuttongroup(f3, "Position", [0 0 1 1]);
     
  switch (opcion)
  case 1 % Pto: 1
    t = evalc('funcionTransfOriginal');
    fprintf("Funcion original: %s\n", t)
    %uicontrol(results, "style", "text", "string", "Pol. Numerador", "position", [5 5 110 30])
    %uicontrol(results, "style", "text", "string", t, "position", [115 5 600 600]);
  case 2 % Mostrar polos y ceros y ganancia (ptos: 2, 3, 4) 
    fprintf("Polos: %f\n", Pol); 
  case 3
    fprintf("Ceros: %f\n", Zer);
  case 4
   fprintf("Ganancia: %f\n", k);
  case 5 % Pto: 5
   t2 = evalc('funcionTransfFact');
   fprintf("Funcion factorizada: %s", t2);
  case 6 % Mostrar graficamente los polos y ceros (pto: 6)
    graficar(funcionTransfFact);
  case 7 % Pto: 7
    index = 1;
    cantCeros = 0;
    esEstable = true;
    for i = 1:length(Pol)    
      if (Pol(index) > 0)
        esEstable = false;
        break;
      elseif (Pol(index) == 0)
        cantCeros ++;      
      endif
      index++;
    endfor
    
    if(cantCeros > 1 || !esEstable)
      fprintf("Funcion INESTABLE\n");
    else
      fprintf("Funcion ESTABLE\n");
    end
  case 8 % Pto: 1,2,3,4,5,6,7
    t = evalc('funcionTransfOriginal');
    t2 = evalc('funcionTransfFact');
    fprintf("Funcion original: %s\n", t);  
    fprintf("Polos: %f\n", Pol);   
    fprintf("Ceros: %f\n", Zer);  
    fprintf("Ganancia: %f\n", k); 
    fprintf("Funcion factorizada: %s", t2);  
    graficar(funcionTransfFact);
    
    index = 1;
    cantCeros = 0;
    esEstable = true;
    for i = 1:length(Pol)    
      if (Pol(index) > 0)
        esEstable = false;
        break;
      elseif (Pol(index) == 0)
        cantCeros ++;      
      endif
      index++;
    endfor
    
    if(cantCeros > 1 || !esEstable)
      fprintf("Funcion INESTABLE\n");
    else
      fprintf("Funcion ESTABLE\n");
    end
    
  otherwise
    fprintf("Opcion invalida!!\n");  
  endswitch
endfunction

function graficar(func)  
  f2 = figure ("position", [ 250 150 600 500 ]);
  pzmap(func);
endfunction
  
