function [index,C,sumd] = Kmeans(sample, k, threshold, n)
%K��ֵ�㷨
%C:k��������
%index:�����ÿ�������ı��
%sumd:�����㵽��Ӧ�Ĵ��ĵľ���
%sample:��Ҫ���о��������
%k:���ִصĸ���
%threshold:�������ֵ
%n����������
iter = 0;
dim = size(sample);
index = zeros(dim(1), 1);
dist = zeros(k, 1);
C = sample(randperm(dim(1), k), :);
while 1
    sumd = zeros(dim(1), 1);
    for i = 1:dim(1)
        for j = 1:k
            X = [sample(i, :);C(j, :)];
            dist(j) = cal_dist(X, 2);
        end
        [d, idx] = min(dist);
        sumd(i) = d;
        index(i) = idx;
    end
    new_C = zeros(k, dim(2));
    c = 0;
    for i = 1:k
        count = 0;
        for j = 1:dim(1)
            if index(j) == i
                count = count + 1;
                new_C(i, :) = new_C(i, :) + sample(j, :);
            end
        end
        new_C(i, :) = new_C(i, :) / count;
        Y = [new_C(i, :);C(i, :)];
        if cal_dist(Y, 2) <= threshold
            c = c + 1;
        end
    end
    iter = iter + 1;
    if c == k
        break;
    elseif iter > n
        break;
    else
        C = new_C;
    end
end
end
