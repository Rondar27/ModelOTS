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
        
    end
    methods
        function obj = ClassSig(Params, LogLanguage) % �����������
            % ������� ���� Params, ����������� ��� �������������
                Sig  = Params.Sig;
                obj.beta = Sig.beta;
                obj.span = Sig.span;
                obj.sps = Sig.sps;
            % ������������� �������� ���������� �� ����������
                obj.isTransparent = Sig.isTransparent;
            % ���������� LogLanguage
                obj.LogLanguage = LogLanguage;
            % ���������� ������� ��������� �������
                obj.b = rcosdesign(Sig.beta, Sig.span, Sig.sps);
               
        end
        function OutData = StepTx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            % ����� ������ ���� ��������� ������������ �������
            OutData = upfirdn(InData, obj.b, obj.sps);
        end
        function OutData = StepRx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            % ����� ������ ���� ���������, �������� �������� ������������
            % �������
            CF = conv(InData, obj.b); %������������� ����������
            OutData = CF(obj.span*obj.sps + 1:obj.sps:end-obj.span*obj.sps);
        end
    end
end