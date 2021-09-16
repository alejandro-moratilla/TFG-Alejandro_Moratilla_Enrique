%Programa para calcular el factor de idealidad m
function [m_stc]=m_ecuacion(Voc1,Voc2,Isc1,Isc2,Tc,Ns)

Vt=0.02585*(273+Tc)/300;

Vtm=Ns*Vt; % tension termica equivalente para el modulo

m_stc=(Voc1-Voc2)/(log(Isc1/Isc2)*Vtm);
%Voc1 y Isc1 medididos a G=1kW/m^2 y T=25ºC
%Voc2 y Isc2 medididos a G=0.1kW/m^2 y T=25ºC
%Vt=k*T/q 

end
 
 
