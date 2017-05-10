% crear la figura
f = figure ("position", [ 250 80 500 400 ]);
% crear el grupo de botones
gp = uibuttongroup (f, "Position", [ 0 0 1 1 ]);
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
c1 = uicontrol (gp, "style", "checkbox", "string", "Indicar ceros", 
                "position",[ 40 220 150 20 ]);
c1 = uicontrol (gp, "style", "checkbox", "string", "Marcar ganancia", 
                "position",[ 40 190 150 20 ]);
c1 = uicontrol (gp, "style", "checkbox", "string", "Obtener expresión con sus polos, ceros y ganancia", 
                "position",[ 40 160 350 20 ]);
c1 = uicontrol (gp, "style", "checkbox", "string", "Mostrar gráficamente la distribució de polos y ceros", 
                "position",[ 40 130 350 20 ]);
c1 = uicontrol (gp, "style", "checkbox", "string", "Indicar estabilidad del sistema", 
                "position",[ 40 100 350 20 ]);
% crear los botones de decisión
b1 = uicontrol (f, "string", "Aceptar", "position",[50 20 100 40]);
b2 = uicontrol (f, "string", "Ingresar nueva función", "position",[168 20 150 40]);
b3 = uicontrol (f, "string", "Finalizar", "position",[335 20 100 40], "callback", "close");

% create an edit control
% e1 = uicontrol (f, "style", "edit", "string", "editable text", "position",[10 60 300 40]);
% p = uipanel ("title", "Panel Title", "position", [.25 .25 .5 .5]);
% add two buttons to the panel
% b1 = uicontrol ("parent", p, "string", "A Button", "position",[18 10 150 36]);
% b2 = uicontrol ("parent", p, "string", "Another Button", "position",[18 60 150 36]);
