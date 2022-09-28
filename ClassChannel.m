classdef ClassChannel < handle
    properties (SetAccess = private) % Переменные из параметров
        % Нужно ли пропускать сигнал через канал
            isTransparent;
        % Переменная управления языком вывода информации для пользователя
            LogLanguage;
    end
    properties (SetAccess = private) % Вычисляемые переменные
        % Значение средней мощности модуляционного символа
            Ps;
        % Значение средней мощности модуляционного бита
            Pb;
        % Значение средней мощности информационного бита
            Pbd;
        % Значение ошибок временной синхранизации
            time;
        % Число отсчетов на символьный интервал
            sps;
        % Добавка частотная в экспоненте
            freq;
    end
       
    methods
        function obj = ClassChannel(Params, Objs, LogLanguage)
        % Конструктор
            % Выделим поля Params, необходимые для инициализации
                Channel = Params.Channel;
                obj.time = Channel.time;
                obj.sps = Params.Sig.sps;
                obj.freq = Channel.freq;
            % Инициализация значений переменных из параметров
                obj.isTransparent = Channel.isTransparent;
            % Переменная LogLanguage
                obj.LogLanguage = LogLanguage;

            % Определим среднюю мощность модуляционного символа
                Const = Objs.Mapper.Constellation;
                obj.Ps = mean((abs(Const)).^2);

            % Определим среднюю мощность модуляционного бита
            if (strcmp(Params.Mapper.Type, 'QAM') || strcmp(Params.Mapper.Type, 'PSK'))
                obj.Pb = obj.Ps / Objs.Mapper.log2M;
            elseif (strcmp(Params.Mapper.Type, 'DBPSK') || strcmp(Params.Mapper.Type, 'DQPSK'))
                        obj.Pb = 2*obj.Ps / Objs.Mapper.log2M ;
            end
            
            % Определим среднюю мощность информационного бита (энергия,
            % приходящаяся на информационный бит, оказывается больше, так
            % как используются проверочные биты)
                obj.Pbd = obj.Pb;
                % Когда и если будет реализован класс кодирования, то здесь
                % должно будет быть
                % obj.Pbd = obj.Pb / Objs.Encoder.Rate;
        end
        function [OutData, InstChannelParams] = Step(obj, InData, h2dB)
            if obj.isTransparent
                OutData = InData;
                InstChannelParams.Variance = 1;
                return
            end

            % Сформируем АБГШ
                Sigma = sqrt(obj.Pbd * 10^(-h2dB/10) / 2);
                InstChannelParams.Variance = 2*Sigma^2;
                Noise = randn(length(InData), 2) * [1; 1i] * Sigma;

            % Синхронизация по частоте
              InData_freq = InData.*exp(2*pi*1i*(obj.freq/obj.sps)*(0:length(InData)-1)).' ;
%             Добавим его к сигналу
              OutData = circshift(InData_freq,obj.time*obj.sps) + Noise;
%                 если sps = 8, то мб округлить в большую сторону
% %             OutData = circshift(InData,round(obj.time*obj.sps)) + Noise;
%             OutData = circshift(InData,(obj.time*obj.sps)) + Noise;

        end
    end
end