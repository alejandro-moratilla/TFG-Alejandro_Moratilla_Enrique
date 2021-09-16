%function [Rs_NOTC]=calcula_Rs_NOTC(silicio_amorfo,silicio_cristalino,modulo_a_calcular)
%Calcula el valor de la resistencia serie en condiciones estandar(800 W/m2 y 46ºC)

%Se calcula la pendiente Rs
%pendiente_Rs=(Voc_stc-Vm_stc)/(0-Im_stc);
for modulo_a_calcular=1:1:10
%Caso 1:Se separan modulos de silicio amorfo
if modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==5 || modulo_a_calcular==6 || modulo_a_calcular==10
    pendiente_Rs=[35.6019,4.1447,1.8724,1.5181,3.8921]; %Modulos 1,4,5,6,10
    Rs=[11.093,1.501,0.674,0.453,0.698];
else
    pendiente_Rs=[2.6933,32.7826,3.21]; %Modulos 2,3,9
    Rs=[0.765,7.315,1.834];
end


%Caso 2:Se separan modulos de silicio amorfo y silicio cristalino
% if modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==10
%     pendiente_Rs=[35.6019,4.1447,3.8921]; %Modulos 1,4,10
%     Rs=[11.093,1.501,0.698];
% elseif  modulo_a_calcular==2 || modulo_a_calcular==3 || modulo_a_calcular==9
%     pendiente_Rs=[2.6933,32.7826,3.21]; %Modulos 2,3,9
%     Rs=[0.765,7.315,1.834];
% elseif modulo_a_calcular==5 || modulo_a_calcular==6
%     pendiente_Rs=[1.8724,1.5181]; %Modulos 5,6
%     Rs=[0.674,0.453];
% end


kk=polyfit(pendiente_Rs,Rs,1);
Rsi=polyval(kk,pendiente_Rs);
plot(pendiente_Rs,Rs,'x',pendiente_Rs,Rsi);
title('Ajuste de pendiente Rs y Rs teorica a recta');
legend('Puntos Teoricos','Recta Ajustada');

%Valores para caso 1
switch modulo_a_calcular
        case 1
            Valor=1;
        case 2
            Valor=1;
        case 3
            Valor=2;
        case 4
            Valor=2;
        case 5
            Valor=3;
        case 6
            Valor=4;
        case 9
            Valor=3;    
        case 10
            Valor=5;
        otherwise
            Valor=1;
end

% %Valores para caso 2
% switch modulo_a_calcular
%         case 1
%             Valor=1;
%         case 2
%             Valor=1;
%         case 3
%             Valor=2;
%         case 4
%             Valor=2;
%         case 5
%             Valor=1;
%         case 6
%             Valor=2;
%         case 9
%             Valor=3;    
%         case 10
%             Valor=3;
%         otherwise
%             Valor=1;
% end

%Rs_stc=a*pendiente_Rs + b; donde a y b son los coeficientes del ajuste a una recta obtenidos con el polyfit (kk)
%Rs_stc=kk(1)*pendiente_Rs + kk(2);
Rs_NOTC(indice2)=kk(1)*pendiente_Rs(Valor) + kk(2);
a(indice2)=kk(1);
b(indice2)=kk(2);
indice2=indice2+1;
end
