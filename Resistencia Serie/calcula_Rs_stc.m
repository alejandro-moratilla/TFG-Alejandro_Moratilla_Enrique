%function [Rs_stc]=calcula_Rs_stc(silicio_amorfo,modulo_a_calcular)
%Calcula el valor de la resistencia serie en condiciones estandar(1000 W/m2 y 25ºC)

%Se calcula la pendiente Rs
%pendiente_Rs=(Voc_stc-Vm_stc)/(0-Im_stc);
for modulo_a_calcular=1:1:10
%Se separan modulos de silicio amorfo
if modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==5 || modulo_a_calcular==6 || modulo_a_calcular==10
    pendiente_Rs=[31.7978,3.7202,1.4505,1.1677,3.3777]; %Modulos 1,4,5,6,10
    Rs=[18.434,1.886,0.563,0.456,1.356];
else
    pendiente_Rs=[2.5682,28.7986,3.1915]; %Modulos 2,3,9
    Rs=[1.355,12.688,2.399];
end


kk=polyfit(pendiente_Rs,Rs,1);
Rsi=polyval(kk,pendiente_Rs);
plot(pendiente_Rs,Rs,'x',pendiente_Rs,Rsi);
title('Ajuste de pendiente Rs y Rs teorica a recta');
legend('Puntos Teoricos','Recta Ajustada');


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
%Rs_stc=a*pendiente_Rs + b; donde a y b son los coeficientes del ajuste a una recta obtenidos con el polyfit (kk)
%Rs_stc=kk(1)*pendiente_Rs + kk(2);
Rs_stc(indice)=kk(1)*pendiente_Rs(Valor) + kk(2);
a(indice)=kk(1);
b(indice)=kk(2);
indice=indice+1;
end
