classdef ClassSig < handle
    properties (SetAccess = private) % ���������� �� ����������
        % ����� �� ��������� ������������ ������� � ��������� ��� ���������
        % ��� �����
            isTransparent;
        % ���������� ���������� ������ ������ ���������� ��� ������������
            LogLanguage;
    end
    properties (SetAccess = private) % ����������� ����������
        b; %�������� ������������ ������� ���-������� ������������ ��������
        beta;
        span;
        sps; %������� �� ������
        k;
        sps_k;
        temp;
        temp2;
    end
    methods
        function obj = ClassSig(Params, LogLanguage) % �����������
            % ������� ���� Params, ����������� ��� �������������
                Sig  = Params.Sig;
                obj.beta = Sig.beta;
                obj.span = Sig.span;
                obj.sps = Sig.sps;
                obj.k=Sig.k;
                obj.sps_k=round(obj.k*obj.sps);
            % ������������� �������� ���������� �� ����������
                obj.isTransparent = Sig.isTransparent;
            % ���������� LogLanguage
                obj.LogLanguage = LogLanguage;
            % ���������� ������� ��������� �������
                obj.b = rcosdesign(Sig.beta, Sig.span, Sig.sps);
                obj.temp=1;
                obj.temp2=1;
               

        end
        function OutData = StepTx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            
            % ����� ������ ���� ��������� ������������ �������
            %��������  k*sps
            filename="DataSetSymbols\symbols"+obj.temp+".mat";
            save(filename,'InData')
            obj.temp=obj.temp+1;
            OutData = upfirdn(InData, obj.b, obj.sps_k);
%             plot(real(InData))
        end
        function OutData = StepRx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            filename="DataSetSignals\signals"+obj.temp2+".mat";
            save(filename,'InData')
            obj.temp2=obj.temp2+1;
            % ����� ������ ���� ���������, �������� �������� ������������
            % �������
            
            CF = conv(InData, obj.b); %������������� ����������
            OutData = CF(obj.span*obj.sps + 1:obj.sps_k:end-obj.span*obj.sps);
        end
    end
end