%function [Rp_NOTC]=calcula_Rp_NOTC(silicio_amorfo,modulo_a_calcular)
%Calcula el valor de la resistencia paralelo en condiciones NOTC(800 W/m2 y 46ºC)

%En primer lugar se calcula la pendiente de la resistencia paralelo
%pendiente_Rp_modulos=(0-Vm_stc)/(Isc_stc-Im_stc);
%Se calcula la constante de la resistencia paralelo
%Cp_modulos=Rp_teo/pendiente_Rp_modulos;


for modulo_a_calcular=1:1:10
%Se separan modulos de silicio amorfo
if  modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==5 || modulo_a_calcular==6 || modulo_a_calcular==10  %silicio_amorfo==0
    pendiente_Rp_modulos=[579.72,40.6011,38.4076,51.2882,83.9079]; %Modulos 1,4,5,6,10
    Rp_teorica=[950,120,125,155,200];
else
    pendiente_Rp_modulos=[41.6042,391.5137,70.7196]; %Modulos 2,3,9
    Rp_teorica=[60,615,100];
end

kk=polyfit(pendiente_Rp_modulos,Rp_teorica,1);
Rp_teorica_i=polyval(kk,pendiente_Rp_modulos);
plot(pendiente_Rp_modulos,Rp_teorica,'x',pendiente_Rp_modulos,Rp_teorica_i)
title('Ajuste de pendiente Rp y Cp(Rp/Pendiente Rp) a recta');
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

%Como CP=Rp_stc/pendiente_Rp ==> Rp_stc=Cp*pendiente_Rp
Rp_NOTC(indice)=kk(1)*pendiente_Rp_modulos(Valor) + kk(2);
matriz_Rp_NOTC(indice,1)=kk(1)';
matriz_Rp_NOTC(indice,2)=kk(2)';
indice=indice+1;

end
%end