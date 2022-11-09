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
        k;
        sps_k;
        temp;
        temp2;
    end
    methods
        function obj = ClassSig(Params, LogLanguage) % Конструктор
            % Выделим поля Params, необходимые для инициализации
                Sig  = Params.Sig;
                obj.beta = Sig.beta;
                obj.span = Sig.span;
                obj.sps = Sig.sps;
                obj.k=Sig.k;
                obj.sps_k=round(obj.k*obj.sps);
            % Инициализация значений переменных из параметров
                obj.isTransparent = Sig.isTransparent;
            % Переменная LogLanguage
                obj.LogLanguage = LogLanguage;
            % Переменная которая формирует импульс
                obj.b = rcosdesign(Sig.beta, Sig.span, Sig.sps);
                obj.temp=1;
                obj.temp2=1;
               

        end
        function OutData = StepTx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            
            % Здесь должна быть процедура формирования сигнала
            %ДПВБЧЙФШ  k*sps
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
            % Здесь должна быть процедура, обратная поцедуре формирования
            % сигнала
            
            CF = conv(InData, obj.b); %согласованная фильтрация
            OutData = CF(obj.span*obj.sps + 1:obj.sps_k:end-obj.span*obj.sps);
        end
    end
end