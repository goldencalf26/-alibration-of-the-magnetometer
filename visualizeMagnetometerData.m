function visualizeMagnetometerData(Bm,BmCalib, RowsMagneto)
Module_Bm = vecnorm(Bm, 2, 2); % вычисляем модуль каждой строки в исходной матрице Bm
Module_BmCalib = vecnorm(BmCalib, 2, 2); % вычисляем модуль каждой строки в калиброванной матрице BmCalib

figure(1);
scatter3(Bm(:,1), Bm(:,2), Bm(:,3), 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'none');
hold on;
scatter3(BmCalib(:,1), BmCalib(:,2), BmCalib(:,3), 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'none');
xlabel('x');
ylabel('y');
zlabel('z');
legend('Некалиброванные', 'Откалиброванные');
grid on;
title('Распределение магнитного поля в пространстве');

figure(2)
subplot(2,2,1);
hold on
axis equal
grid on
scatter(Bm(:,1), Bm(:,2),'filled', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'none');
scatter(BmCalib(:,1), BmCalib(:,2),'filled', 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'none');
xlabel('X, nT');
ylabel('Y, nT');
hold off
title('Проекция на плоскость (X, Y)');

subplot(2,2,2);
hold on
axis equal
grid on
scatter(Bm(:,1), Bm(:,3),'filled', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'none');
scatter(BmCalib(:,1), BmCalib(:,3),'filled', 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'none');
xlabel('X, nT');
ylabel('Z, nT');
hold off
title('Проекция на плоскость (X, Z)');

subplot(2,2,3);
hold on
axis equal
grid on
scatter(Bm(:,2), Bm(:,3),'filled', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'none');
scatter(BmCalib(:,2), BmCalib(:,3),'filled', 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'none');
xlabel('Y, nT');
ylabel('Z, nT');
hold off
title('Проекция на плоскость (Y, Z)');

NumberMeash = 1:RowsMagneto;


figure(3);
hold on
grid on
plot(NumberMeash, Module_Bm, 'blue');
plot(NumberMeash, Module_BmCalib, 'magenta');
xlabel('Номер пакета, N');
ylabel('Модуль, nT');
legend('Некалиброванные', 'Откалиброванные');
hold off
title('Динамика изменения модуля магнитного поля');
end