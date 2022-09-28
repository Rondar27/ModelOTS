classdef ClassChannel < handle
    properties (SetAccess = private) % ���������� �� ����������
        % ����� �� ���������� ������ ����� �����
            isTransparent;
        % ���������� ���������� ������ ������ ���������� ��� ������������
            LogLanguage;
    end
    properties (SetAccess = private) % ����������� ����������
        % �������� ������� �������� �������������� �������
            Ps;
        % �������� ������� �������� �������������� ����
            Pb;
        % �������� ������� �������� ��������������� ����
            Pbd;
        % �������� ������ ��������� �������������
            time;
        % ����� �������� �� ���������� ��������
            sps;
        % ������� ��������� � ����������
            freq;
    end
       
    methods
        function obj = ClassChannel(Params, Objs, LogLanguage)
        % �����������
            % ������� ���� Params, ����������� ��� �������������
                Channel = Params.Channel;
                obj.time = Channel.time;
                obj.sps = Params.Sig.sps;
                obj.freq = Channel.freq;
            % ������������� �������� ���������� �� ����������
                obj.isTransparent = Channel.isTransparent;
            % ���������� LogLanguage
                obj.LogLanguage = LogLanguage;

            % ��������� ������� �������� �������������� �������
                Const = Objs.Mapper.Constellation;
                obj.Ps = mean((abs(Const)).^2);

            % ��������� ������� �������� �������������� ����
            if (strcmp(Params.Mapper.Type, 'QAM') || strcmp(Params.Mapper.Type, 'PSK'))
                obj.Pb = obj.Ps / Objs.Mapper.log2M;
            elseif (strcmp(Params.Mapper.Type, 'DBPSK') || strcmp(Params.Mapper.Type, 'DQPSK'))
                        obj.Pb = 2*obj.Ps / Objs.Mapper.log2M ;
            end
            
            % ��������� ������� �������� ��������������� ���� (�������,
            % ������������ �� �������������� ���, ����������� ������, ���
            % ��� ������������ ����������� ����)
                obj.Pbd = obj.Pb;
                % ����� � ���� ����� ���������� ����� �����������, �� �����
                % ������ ����� ����
                % obj.Pbd = obj.Pb / Objs.Encoder.Rate;
        end
        function [OutData, InstChannelParams] = Step(obj, InData, h2dB)
            if obj.isTransparent
                OutData = InData;
                InstChannelParams.Variance = 1;
                return
            end

            % ���������� ����
                Sigma = sqrt(obj.Pbd * 10^(-h2dB/10) / 2);
                InstChannelParams.Variance = 2*Sigma^2;
                Noise = randn(length(InData), 2) * [1; 1i] * Sigma;

            % ������������� �� �������
              InData_freq = InData.*exp(2*pi*1i*(obj.freq/obj.sps)*(0:length(InData)-1)).' ;
%             ������� ��� � �������
              OutData = circshift(InData_freq,obj.time*obj.sps) + Noise;
%                 ���� sps = 8, �� �� ��������� � ������� �������
% %             OutData = circshift(InData,round(obj.time*obj.sps)) + Noise;
%             OutData = circshift(InData,(obj.time*obj.sps)) + Noise;

        end
    end
end