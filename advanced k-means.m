A = load('haberman.data.txt');
A(:,4) = [];
n1 = size(A,1);
Maha = zeros(20,1);
Total1 = 0;
Total2 = 0;
c = 2;
temp =0;
newmean0 = [0,0,0];
newmean1 = [0,0,0];
x1= zeros(n1,1);
x2= zeros(n1,1);
d = zeros(n1,1);
d1 = zeros(n1,1);
d2 = zeros(n1,1);
u1 = [0 0 0]

    Total1 = 0;
    Total2 = 0;
    count0 =0;
    count1 =0;
  for j= 1:n1
    temp = A(j,:);
    x1(j,1)  = pdist2(u1,temp,'euclidean');
  end
x2 = sort(x1);
u1 = [0 0 0];
u2 = [0 0 0];
B = load('newkmeans.csv');
B(:,4) = [];
n2 = size(B,1);
m = (n2)/2;
y = B(1:m,:);
z = B(m+1:n2,:);
u1 = y(((m+1)/2),:,:);
u2 = z(((m+1)/2),:,:);

for i=1:7
    count0=0;
    count1=0;
    Total1=0;
    Total2=0;
    for j= 1:n2
    temp = B(j,:);
    x3  = sqrt((u1-temp)* transpose(u1-temp));
    x4  = sqrt((u2-temp)* transpose(u2-temp));
    
            if( x3 < x4)            
                Z(j,1) = 0;                         
                d(j,1) = x3;
            else
                Z(j,1) = 1;
                d(j,1) = x4;
            end
        
    end


    for l=1:n2
        if(Z(l,1) == 0)
            count0 = count0 +1;
          end
    end
    count1 = n2 - count0;
    
   for l =1:n2
        if(Z(l,1) ==0)
            newmean0 = newmean0 + B(l,:);
        else
            newmean1 = newmean1 + B(l,:);
        end
end     
  newmean0 = newmean0/count0;
  newmean1 = newmean1/count1; 
  
    u1 = newmean0;
    u2 = newmean1;
   for l =1:n2
    temp = B(l,:);   
        if(Z(l,1) ==0)
          d1(l,1)  = sqrt((u1-temp)* transpose(u1-temp));
        else
          d1(l,1)  = sqrt((u2-temp)* transpose(u2-temp));
        end
   end
   for k = 1:n2
     temp = B(k,:);
       if ( d1(k,1) > d(k,1))
            
             x3  = sqrt((u1-temp)* transpose(u1-temp));
             x4  = sqrt((u2-temp)* transpose(u2-temp));
   
            if( x3 < x4)           
                Z(k,1) = 0;                        
              
            else
                Z(k,1) = 1;
            end
               
       end
   end
     for l =1:n2
        if(Z(l,1) == 0)
            temp = B(l,:);  
            Total1 = Total1 + sqrt((u1-temp)* transpose(u1-temp));
        else
            temp = B(1,:);
            Total2 = Total2 + sqrt((u2-temp)* transpose(u2-temp));
            
        end
     end
     Maha (i,1) = Total1 + Total2; 

     
end     
figure(1)
plot(Maha)
axis([1,9,3000,7000])




cluster0 = [];
cluster1 = [];
for i=1:n2    
    
    if (Z(i,1) == 0)
        cluster0 = [cluster0 ; B(i,:)];
    else
        cluster1 = [cluster1 ; B(i,:)];
        
    end
        
    
end

figure(2)
plot3(cluster0(:,1),cluster0(:,2),cluster0(:,3),'+')
hold on
plot3(cluster1(:,1),cluster1(:,2),cluster1(:,3),'*')
hold on
scatter(newmean0(1,1),newmean0(1,2),newmean0(1,3),'g')
hold on
scatter(newmean1(1,1),newmean1(1,2),newmean1(1,3),'r')
hold off
 
