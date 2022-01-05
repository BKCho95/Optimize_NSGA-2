%% Metamodeling using RSM %%
clc; clear all; close all; warning off;


%% --------- Selection of input values (User Define) --------- %%
Filename = 'CCD_Results.xlsx';   % �����ͼ�(��������) �ҷ�����
Data_x = xlsread(Filename,1,'A2:A19');   % ���躯�� �����ͼ� ����
Data_y = xlsread(Filename,1,'B2:B19');   % Ư��ġ �����ͼ� ����
nfactors = 1;   % ���躯�� ���� ����
% ---------------------------------------------------------------------- %


%% Caculation least square method (polynomial regression of order 2)
size_x = size(Data_x);   % ���躯�� �����ͼ� ������
size_y = size(Data_y);   % Ư��ġ �����ͼ� ������

for i = 1:nfactors
    first_order_x(:,i) = Data_x(:,i);
    second_order_x(:,i) = Data_x(:,i).^2;
end
        
for j = 1:nfactors-1
    for i = j+1:size_x(1,2)
        xx_initial(:,j^3*i) = Data_x(:,j).*Data_x(:,i);
        [row,col,v] = find(xx_initial);
    end
end
        
for k = 0:(nfactors*(nfactors-1)/2)-1
    xx(:,k+1) = v((k*size_x(1,1))+1:(k+1)*size_x(1,1));
end
        
BB = [ones(size_x(1,1),1) first_order_x second_order_x xx];

RSM_coeff = BB\Data_y;   % RSM ��� ���
y_approx = BB*RSM_coeff;   % ������ ���

for i = 1:size_y
    SST1(i,1) = Data_y(i,1);
    SST = sum((SST1-mean(Data_y)).^2);
end

SSR = sum((y_approx-mean(Data_y)).^2);
R_2 = SSR/SST   % �ٻ�� ��Ȯ�� ��� (�������)


%% Plot
plot (Data_y,y_approx,'ob',Data_y,Data_y,'k');
xlabel('Actual','fontsize',15,'fontname','times new roman')
ylabel('RSM','fontsize',15,'fontname','times new roman')
legend('RSM','Actual')


%% Save result
save OutputFile-RSM_Coefficient.txt RSM_coeff -ascii