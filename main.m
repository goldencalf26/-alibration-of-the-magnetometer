% ��������� ��� ���������� � ������������ ������ � �������� ������ ������������
% �����: ������� �����. ��������: ��������� �����������, ������� �����������
% ������������
% ����: 03.04.2023

clear all; clc; close all;
% ���������� ������ �� ���� � �������������� � ������ uint8
readMagnetometerData;

% ���������� ����� ��������� � ������������
Bm = extractMagnetometerReadings(data);

% ���������� ������
Bm = Bm*100; % �� ��� � ��� (1��� = 100 ���)
RowsMagneto = size((Bm),1); % ����� ����� � ������� ��������� ������������

% ���������� ������� D
D = [Bm.^2, 2*Bm(:,2).*Bm(:,3), 2*Bm(:,1).*Bm(:,3), 2*Bm(:,1).*Bm(:,2), 2*Bm(:,1), 2*Bm(:,2), 2*Bm(:,3), ones(size(Bm,1),1)];
D = D';

K = 4;
C1 = [-1 K/2-1 K/2-1 zeros(1,3);...
    K/2-1 -1 K/2-1 zeros(1,3);...
    K/2-1 K/2-1 -1 zeros(1,3);...
    zeros(1,3) -K zeros(1,2);...
    zeros(1,4) -K 0 ;...
    zeros(1,5) -K];
DDT = D*D';

S11 = DDT(1:6, 1:6);
S12 = DDT(1:6, 7:10);
S22 = DDT(7:10, 7:10);
W = C1 \ (S11 - S12 * (S22 \ S12'));

[W_eigvec, W_eigval] = eig(W);
[~, maxEigIndex] = max(diag(W_eigval));
u1 = W_eigvec(:, maxEigIndex); % ����������� ������, ��������������� ������������� ������������ �����
u2 = -S22 \ S12' * u1;
u = [u1; u2];
a = u(1); b = u(2); c = u(3); f = u(4); g = u(5);
h = u(6); p = u(7); q = u(8); r = u(9); d = u(10);
M = [a h g; h b f; g f c];
vn = [p q r]';

% ������ �������� ����
vb = -M \ vn;

% ���������� ������
Mod_Bm = vecnorm(Bm - vb', 2, 2); % ��������� ������ ������ ������ � Bm
Bt = mean(Mod_Bm); % ������ Bt
Aerr = Bt / (sqrt(vn' / M * vn - d)) * sqrtm(M); % ��������� ������� Aerr
BmCalib = (Aerr * (Bm - vb').')'; % ��������� ������ � Bm

% ������������ ������
visualizeMagnetometerData(Bm, BmCalib, RowsMagneto)


