function [G_stc,T_stc,pendiente_Rs_stc,pendiente_Rp_stc]=encuentra_valores_Rs_Rp_stc(irradiancias,temperaturas,Voc_todas,Isc_todas,Vm_vector,datos_modulo,modulo_a_calcular)
%Calcula los parametros del modulo en condiciones estandar para calcular
%las pendientes de Rp y de Rs

%Se crea Im_todas
Im_todas=datos_modulo(:,6)';

%Se Calculan las condiciones a 1000W/m^2 y 25ºC
error=1000;
indice=0;
for i=1:1:length(irradiancias)
    error_nuevo=sqrt((1000-irradiancias(i))^2+(25-temperaturas(i))^2);
    if error_nuevo<error
        error=error_nuevo;
        indice=i;
    end
end
    Voc_stc=Voc_todas(indice);
    Isc_stc=Isc_todas(indice);
    Vm_stc=Vm_vector(indice);
    Im_stc=Im_todas(indice);
    G_stc=irradiancias(indice);
    T_stc=temperaturas(indice);
    
    pendiente_Rs_stc=-(Voc_stc-Vm_stc)/(0-Im_stc);
    pendiente_Rp_stc=-(0-Vm_stc)/(Isc_stc-Im_stc);
    fprintf('Los datos para el modulo %d son:',modulo_a_calcular);

end