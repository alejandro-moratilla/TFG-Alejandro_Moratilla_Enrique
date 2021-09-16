function [par_A_optimo,par_B_optimo,par_C_optimo]=calcula_optimos(x_vector,y_vector)
% Calculo de 3 parametros optimos para funcion 
% El parámetro par_A_optimo es el n(25).
% Efectivamente, en los cálculos, la temperatura tiene que estar en K.
%Es importante que, si el valor óptimo está en el límite de los valores iniciales, cambiar ese límite.


size_x=size(x_vector);
size_x=size_x(2);

par_A_ini=0;
par_A_fin=10;
paso_par_A=0.001;

par_B_ini=0;
par_B_fin=0;
paso_par_B=10000;

par_C_ini=0;
par_C_fin=0;
paso_par_C=1000;

indice_par_A=0;
for par_A=par_A_ini:paso_par_A:par_A_fin
    indice_par_A=indice_par_A+1;
    indice_par_B=0;

    for par_B=par_B_ini:paso_par_B:par_B_fin  % Voc a 25 ºC, teoricamente
        indice_par_B=indice_par_B+1;
        indice_par_C=0;
        for par_C=par_C_ini:paso_par_C:par_C_fin
            indice_par_C=indice_par_C+1;
            par_A_vector(indice_par_A,indice_par_B,indice_par_C)=par_A;
            par_B_vector(indice_par_A,indice_par_B,indice_par_C)=par_B;
            par_C_vector(indice_par_A,indice_par_B,indice_par_C)=par_C;

            %%%%%%%%%%%% ECUACION TEORICA A AJUSTAR %%%%%%%%%%%%%%%%%%%%%%%
            y_vector_teorico=par_A.*(x_vector+273)/(25+273); %n(T)=n(25)*T/25
 
            errorcm_y(indice_par_A,indice_par_B,indice_par_C)=sqrt(sum((y_vector_teorico-y_vector).^2)/size_x);
         end % for par_C
     end % for par_B
end % for par_A
 

indice_min_error_y=find(errorcm_y==min(min(min(errorcm_y))));
kk_escalar_error=isscalar(errorcm_y);
  
if kk_escalar_error==0
    indice_min_error_y=indice_min_error_y(1);      
end

errorcm_y=errorcm_y(indice_min_error_y);

%Comprobacion extremo par_A
par_A_optimo=par_A_vector(indice_min_error_y);

if par_A_optimo==par_A_ini || par_A_optimo==par_A_fin
    disp('error, par_A optimo en extremo, podria no ser correcto');
    pause;
end 

%Comprobacion extremo par_B
par_B_optimo=par_B_vector(indice_min_error_y);
 
if par_B_optimo==par_B_ini||par_B_optimo==par_B_fin
    disp('error, par_B opt. en extremo, puede no ser correcto');
    % pause;
end 

%Comprobacion extremo par_B
par_C_optimo=par_C_vector(indice_min_error_y);

if par_C_optimo==par_C_ini|par_C_optimo==par_C_fin
    disp('error, par_C opt. en extremo, puede no ser correcto');
    %  pause;
end 


%%%%%%%%%%%% ECUACION TEORICA %%%%%%%%%%%%%%%%%%%%%%%
y_teorico=par_A_optimo.*(x_vector+273)/(25+273);
                                               
y_teorico./y_vector;
%figure;
%plot(x_vector,y_vector,x_vector,y_teorico,'x');
%title('Calcula optimos');
end

