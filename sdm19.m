
%%
close all;
clear all;

rand('seed',40);
%x = 20*rand(40,20);
set(0,'DefaultTextFontName','Times',...
      'DefaultTextFontSize',28,...
      'DefaultAxesFontName','Times',...
      'DefaultAxesFontSize',28,...
      'DefaultLineLineWidth',4,...
      'DefaultLineMarkerSize',9.75)
set(gcf,'unit','centimeters','position',[3 5 18 18])
set(gca,'Position',[.15 .15 .8 .75]);

ori_dim=3;
pro_dim=2;
data_size=200;
data = 20*rand(ori_dim,data_size);

%figure;
for i=1:100
    data(2,i)=0;
    if (data(3,i)<data(1,i))
        data(3,i)=data(1,i);
    end
     plot3(data(1,i),data(2,i),data(3,i),'ro','MarkerSize',5)
     hold on;
end

for i=101:200
    data(1,i)=0;
    if (data(3,i)<data(2,i))
        data(3,i)=data(2,i);
    end
     plot3(data(1,i),data(2,i),data(3,i),'b*','MarkerSize',5)
     hold on;
end
grid on;
%%

data_ori=data;
lambda=75;
mu=lambda;
%[ss,vv,dd]=svd(data_ori,0);
x = data;
x = normc(x);
I = eye(ori_dim);
U = I(:,1:pro_dim);
niter=200;
V = rand(pro_dim,data_size);
obj=zeros(niter,1);
for i=1:niter
    %V_old = V;
    for j=1:data_size
        V(:,j) = (lambda-2)*V(:,j)+2*U'*x(:,j);
        V(:,j) = V(:,j)/norm(V(:,j));
    end
    %gra = sum(dot(U'*(U*V-x),V_old-V))
    M = 2*(x-U*V)*V'+mu*U;
    [s,~,d]=svd(M,0);
    U=s*d';
    %obj(i)=norm(x-U*V,'fro');
end
%plot(obj,'MarkerSize',5)
xlabel('x')
ylabel('y')
zlabel('z')
figure
plot(V(1,1:100),V(2,1:100),'ro','MarkerSize',5)
hold on
plot(V(1,101:200),V(2,101:200),'b*','MarkerSize',5)
%%
idx = kmeans(data_ori',2);
figure
for i=1:200
    if idx(i)==1
        plot3(data_ori(1,i),data_ori(2,i),data_ori(3,i),'ro','MarkerSize',5)
    else
        plot3(data_ori(1,i),data_ori(2,i),data_ori(3,i),'b*','MarkerSize',5)
    end
    hold on
end
grid on;
