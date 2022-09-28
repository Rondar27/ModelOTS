classdef ClassInterleaver < handle
    properties (SetAccess = private) % ���������� �� ����������
        % ����� �� ��������� ����������� � �������������
            isTransparent;
        % ���������� ���������� ������ ������ ���������� ��� ������������
            LogLanguage;
    end
    properties (SetAccess = private) % ����������� ����������
    end
    methods
        function obj = ClassInterleaver(Params, LogLanguage) % �����������
            % ������� ���� Params, ����������� ��� �������������
                Interleaver  = Params.Interleaver;
            % ������������� �������� ���������� �� ����������
                obj.isTransparent = Interleaver.isTransparent;
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