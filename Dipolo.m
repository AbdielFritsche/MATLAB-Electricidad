clear ; close all; clc;
minX = -10; maxX=10;
minY = -10; maxY=10;
d = .5;
x = minX:d:maxX;
y = minY:d:maxY;
[Cx,Cy] = meshgrid(x,y);

%posicion particula negativa
pXn = 4; pYn=-2; a = 1;     %posicion suponiendo puntos en base a metros
%posicion particula positiva
pXp = 1; pYp=2;                 %posicion suponiendo puntos en base a metros

%campo electrico
Qn = -5*10^-6; Qp = 12*10^-6;
ke = 8.99*10^9;

Rx = Cx-pXn;
Ry = Cy-pYn;
R = sqrt(Rx.^2+Ry.^2);
Ex = (ke.*Qn).*(Rx./R.^3);
Ey = (ke.*Qn).*(Ry./R.^3);

Rx2 = Cx-pXp;
Ry2 = Cy-pYp;
R2 = sqrt(Rx2.^2+Ry2.^2);
Ex1 = Ex + ((ke.*Qp).*(Rx2./R2.^3));
Ey1 = Ey + ((ke.*Qp).*(Ry2./R2.^3));
E =  sqrt(Ex1.^2+Ey1.^2);

%Componentes
U = Ex1./E; V = Ey1./E;
U2 = Ex1; V2 = Ey1;

Volts = ke*((Qp./R2)+(Qn./R));

figure(); set(gcf, WindowState = 'maximized'); 
dipoloNormalizado = quiver(Cx,Cy,U,V,Color='black',LineWidth=1.5,AutoScaleFactor=0.8);
hold on
grid on
dipoloSinNormalizar = quiver(Cx,Cy,U2,V2,Color='black',LineWidth=1.5,AutoScaleFactor=0.8);
title('Dipolo Electrico'); axis([-8 8 -8 8]); axis equal
particulaN = rectangle('Position',[pXn-a/2,pYn-a/2,a,a],'Curvature',[1,1],'FaceColor','blue', ...
    'EdgeColor','blue');
signoN = text(pXn-.2,pYn,'-','Color','White','FontSize',40);
particulaP = rectangle('Position',[pXp-a/2,pYp-a/2,a,a],'Curvature',[1,1],'FaceColor','red', ...
    'EdgeColor','red');
signoP = text(pXp-.2,pYp,'+','Color','White','FontSize',40);
xlabel('Campo electrico componente X') 
ylabel('Campo electrico componente Y') 

disp('Haz clic en el gráfico para obtener el valor de Voltaje (presiona Enter para salir)');
while true
    [x, y] = ginput(1); % obtener la posición del clic
    if isempty(x) % si se presiona Enter, salir del bucle
        break;
    end
    % interpolar el valor de Voltaje en la posición del clic
    v = interp2(Cx, Cy, Volts, x, y);
    ex = interp2(Cx, Cy, Ex1, x, y);
    ey = interp2(Cx, Cy, Ey1, x, y);
    % mostrar el valor en la pantalla
    disp(['El valor de Voltaje en la posición (', num2str(x), ', ', num2str(y), ') es ', num2str(v)]);
    disp(['El valor del componente X del campo electrico  en la posición (', num2str(x), ', ', ...
        num2str(y), ') es ', num2str(ex)]);
    disp(['El valor del componente Y del campo electrico en la posición (', num2str(x), ', ', ...
        num2str(y), ') es ', num2str(ey)]);
end
hold off

