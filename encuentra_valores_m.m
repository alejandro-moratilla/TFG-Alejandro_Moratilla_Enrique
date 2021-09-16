function [Voc1,Voc2,Tc,Isc1,Isc2]=encuentra_valores_m(irradiancias,temperaturas,Voc_todas,Isc_todas)
% Calcula los valores que se utilizan en la funcion m_ecuacion

%En primer lugar se calculan las condiciones a 1000W/m^2
error=1000;
indice1=0;
for i=1:1:length(irradiancias)
    error_nuevo=sqrt((1000-irradiancias(i))^2+(25-temperaturas(i))^2);
    if error_nuevo<error
        error=error_nuevo;
        indice1=i;
    end
end
    Voc1=Voc_todas(indice1);
    Isc1=Isc_todas(indice1);
    
    
%En segundo lugar se calculan las condiciones a 100W/m^2
error=1000;
indice2=0;
for i=1:1:length(irradiancias)
    error_nuevo=sqrt((100-irradiancias(i))^2+(25-temperaturas(i))^2);
    if error_nuevo<error
        error=error_nuevo;
        indice2=i;
    end
end
    Voc2=Voc_todas(indice2);
    Isc2=Isc_todas(indice2);

%Optimizacion de Tc
array=[temperaturas(indice1),temperaturas(indice2)];
Tc=mean(array);

% if abs(25-temperaturas(indice1))<abs(25-temperaturas(indice2))
%     Tc=temperaturas(indice1);
% else
%     Tc=temperaturas(indice2);
% end

end
