classdef Evaluator
    %EVALUATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        labels;
        scores;
        AP;
        metric;
    end
    
    methods
        function obj = Evaluator(metric)
            % set default
            obj.metric = 'AP'; % only AP has been implemented so far
            if nargin > 0
                obj.metric = metric; % otherwise must be a handle to an 
                % evaluator function taking as input the true labels and 
                % the predicted scores
            end
        end
        function obj = evaluate(obj)
        end
        function AP = averagePrecision(labels, scores)
            [~,IDs] = sort(scores,'descend');
            Ranked = labels(IDs(:));
            
            AP = 0;
            for i=1:length(Ranked)
                if Ranked(i) ==1
                    temp = Ranked(1:i);
                    TP = sum(temp == 1);
                    Pr = TP/length(temp);
                    AP = AP + Pr;
                end
            end
            
            Total = sum(Ranked == 1);
            AP = AP/Total;
        end
    end
    
end

