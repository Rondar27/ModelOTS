classdef ClassSig < handle
    properties (SetAccess = private) % Переменные из параметров
        % Нужно ли выполнять формирование сигнала и выполнять его обработку
        % при приёме
            isTransparent;
        % Переменная управления языком вывода информации для пользователя
            LogLanguage;
    end
    properties (SetAccess = private) % Вычисляемые переменные
        b; %Создание формирующего импульс КИХ-фильтра приподнятого косинуса
        beta;
        span;
        sps; %Выборки на символ
        
    end
    methods
        function obj = ClassSig(Params, LogLanguage) % Конструктор
            % Выделим поля Params, необходимые для инициализации
                Sig  = Params.Sig;
                obj.beta = Sig.beta;
                obj.span = Sig.span;
                obj.sps = Sig.sps;
            % Инициализация значений переменных из параметров
                obj.isTransparent = Sig.isTransparent;
            % Переменная LogLanguage
                obj.LogLanguage = LogLanguage;
            % Переменная которая формирует импульс
                obj.b = rcosdesign(Sig.beta, Sig.span, Sig.sps);
               
        end
        function OutData = StepTx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            % Здесь должна быть процедура формирования сигнала
            OutData = upfirdn(InData, obj.b, obj.sps);
        end
        function OutData = StepRx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            % Здесь должна быть процедура, обратная поцедуре формирования
            % сигнала
            CF = conv(InData, obj.b); %согласованная фильтрация
            OutData = CF(obj.span*obj.sps + 1:obj.sps:end-obj.span*obj.sps);
        end
    end
end