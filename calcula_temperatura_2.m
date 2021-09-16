function [matriz,array_medias,array_Tc]=calcula_temperatura_2(temperaturas,error_temperatura)
%Calcula el array de las temperaturas por grupos que se utilizan en m_ecuacion_2
%Tambien calcula la media de cada conjunto de temperaturas

%Se crea una copia del array temperaturas porque se va a modificar
for w=1:1:length(temperaturas)
    copia_temperaturas(w)=temperaturas(w);
end

%Se crea matriz vacia para ver resultados
for x=1:1:6
    for y=1:1:5
        matriz(x,y)=NaN; %Para que no haya problemas con la media
    end
end

indice1=1;
indice_matriz=1;
indice2=1;
for i=20:1:64
    y=find((copia_temperaturas>=i-error_temperatura) & (copia_temperaturas<=i+error_temperatura));
    if length(y)>1  %%Modificar en caso de que sea necesario
        for j=1:1:length(y)
            matriz(indice_matriz,j)=copia_temperaturas(y(j));
            copia_temperaturas(y(j))=0;  %Se elimina para que no entre en otro grupo
        end
        array_medias(indice1)=mean(matriz(indice_matriz,:),'omitnan');
        indice1=indice1+1;
        
        %Crear array_Tc con las temperaturas mas cercanas a la media
        %Hay que aproximarlo al valor que mas se acerque del array, porque 
        %tiene que estar en temperaturas
        error=abs(mean(matriz(indice_matriz),'omitnan')-matriz(indice_matriz,1));
        valor=matriz(indice_matriz,1);
        for k=2:1:length(y)
            if abs(mean(matriz(indice_matriz),'omitnan')-matriz(indice_matriz,k))<error
                valor=matriz(indice_matriz,k);
                error=abs(mean(matriz(indice_matriz),'omitnan')-matriz(indice_matriz,k));
            end
        end
        array_Tc(indice2)=valor;
        indice2=indice2+1; %Se incrementa una columna al vector
        
        indice_matriz=indice_matriz+1; %Se incrementa una fila a la matriz
    end
end

end