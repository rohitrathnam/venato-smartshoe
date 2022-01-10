function [IC_L, FC_L, IC_R, FC_R] = IC_FC_estimation(acc_L,gyr_L,acc_R,gyr_R,fs)


%IC_L=initial contacts left ankle
%IC_R=initial contacts right ankle
%FC_L=final contacts left ankle
%FC_R=final contact right ankle

%acc/gyr(:,1)--> Vertical (V)
%acc/gyr(:,2)--> MedioLateral (ML)
%acc/gyr(:,3)--> AnteroPosterior (AP)

%acceleration in m/s^2
%angular velocity in rad/s
acc={acc_L, acc_R};
gyr={gyr_L, gyr_R};

for n=1:2
    
    TSW=find(gyr{n}(:,2)>0.2*max(gyr{n}(:,2))); %trusted swing phase
    TCS=find(gyr{n}(:,2)<0.2*max(gyr{n}(:,2))); %candidate stance
    
    len(1)=0;
    flag=0;
    j=1;
    
    %Computation of std of each candidate stance
    
    for i=1:length(TCS)-1
        if flag==0
            begin_CS(j)=TCS(i);
        end
        
        if TCS(i+1)==TCS(i)+1
            len(j)=len(j)+1;
            flag=1;
        elseif TCS(i+1)~=TCS(i)+1 && len(j)>=50
            flag=0;
            end_CS(j)=TCS(i);
            std_CS(j)=std(gyr{n}(begin_CS(j):end_CS(j),2));
            j=j+1;
            len(j)=0;
        elseif TCS(i+1)~=TCS(i)+1 && len(j)<=50
            flag=0;
            len(j)=0;
        end
        
    end
    if length(begin_CS)~=length(end_CS)
        begin_CS(end)=[];
        len(end)=[];
    end
    
    %Computation of TS interval--> std<0.6 std of candidate stance
    std1=zeros(length(begin_CS),fix(max(len)/2));
    for j=1:length(begin_CS)
        flag=0;
        for i=1:fix(len(j)/2)
            std1(j,i)=std(gyr{n}((begin_CS(j)+i-1):(end_CS(j)-i+1),2));
            if std1(j,i)<0.6*std_CS(j)&&flag==0
                begin_ST(j)=begin_CS(j)+i-1;  %find could be used
                end_ST(j)=end_CS(j)-i+1;
                flag=1;
            end
        end
    end
    
    %computation of TIC and TFC, intervals including initial and final contacts
    begin_TIC=begin_CS; end_TIC=begin_ST;
    begin_TFC=end_ST; end_TFC=end_CS;
    
    % search for initial contacts in TIC
    nor_max=0;ind=0;
    for i=1:length(begin_TIC)
        for j=begin_TIC(i):end_TIC(i)
            if norm(acc{n}(j,:))>nor_max
                nor_max=norm(acc{n}(j,:));
                ind=j;
            end
        end
        IC(i)=fs*find(min(gyr{n}((begin_TIC(i):ind),2)))+begin_TIC(i); %index of min angular velocity before max acc 
        nor_max=0;
    end
    
    % search for final contacts in TFC
    for i=1:length(begin_TFC)
        FC(i)=fs*find(min(acc{n}(find(min(gyr_R(begin_TFC(i):end_TFC(i),2)))+begin_TFC(i):end_TFC(i),3)))+find(min(gyr{n}(begin_TFC(i):end_TFC(i),2)))+begin_TFC(i);
    end
    
    if n==1
        IC_L=IC;
        FC_L=FC;
    else
        IC_R=IC;
        FC_R=FC;
    end
    
end

end
