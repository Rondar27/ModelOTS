classdef ClassEncoder < handle
    properties (SetAccess = private) % ���������� �� ����������
        % ����� �� ��������� ����������� � �������������
            isTransparent;
        % ���������� ���������� ������ ������ ���������� ��� ������������
            LogLanguage;
    end
    properties (SetAccess = private) % ����������� ����������
    end
    methods
        function obj = ClassEncoder(Params, LogLanguage) % �����������
            % ������� ���� Params, ����������� ��� �������������
                Encoder  = Params.Encoder;
            % ������������� �������� ���������� �� ����������
                obj.isTransparent = Encoder.isTransparent;
            % ���������� LogLanguage
                obj.LogLanguage = LogLanguage;
        end
        function OutData = StepTx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            % ����� ������ ���� ��������� �����������
            OutData = InData;
        end
        function OutData = StepRx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            % ����� ������ ���� ��������� �������������
            OutData = InData;
        end
    end
end