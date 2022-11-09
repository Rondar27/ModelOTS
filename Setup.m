% End of Params
% Common.NumWorkers=4;
Mapper.isTransparent = false;
Channel.isTransparent = false;
Sig.isTransparent = false;
Sig.beta = 1;  %Фактор спада
Sig.span = 16; %Количество символов
Sig.sps = 100; %Выборки на символ
Sig.k =0.8;
Channel.time = 0; %Значение ошибок временной синхранизации
Channel.freq = 0; 
Mapper.Type = 'QAM';
Mapper.ModulationOrder = 4;
Source.NumBitsPerFrame = 1000; %по умолчанию 1000 
BER.BERNumRateDigits = 8;
BER.FERNumRateDigits = 5;
BER.BERPrecision = 5;
BER.h2Precision = 0;
BER.h2dBInitStep = 1;
BER.h2dBMaxStep = 1;
BER.h2dBMinStep = 1;

%Отношения сигнал/шум:
BER.h2dBInit = 10;
BER.h2dBMax = 10;

% 1End of Params
% Common.NumWorkers=4;
% Mapper.isTransparent = false;
% Channel.isTransparent = false;
% Sig.isTransparent = false;
% Sig.beta = 1;  %Фактор спада
% Sig.span = 16; %Количество символов
% Sig.sps = 100; %Выборки на символ
% Sig.k =1;
% Channel.time = 0; %Значение ошибок временной синхранизации
% Channel.freq = 0; 
% Mapper.Type = 'QAM';
% Mapper.ModulationOrder = 4;
% Source.NumBitsPerFrame = 1000; %по умолчанию 1000 
% BER.BERNumRateDigits = 8;
% BER.FERNumRateDigits = 5;
% BER.BERPrecision = 5;
% BER.h2Precision = 0;
% BER.h2dBInitStep = 1;
% BER.h2dBMaxStep = 1;
% BER.h2dBMinStep = 1;
% 
% 
% BER.h2dBInit = 0;% Отношения сигнал/шум:
% BER.h2dBMax = 10;