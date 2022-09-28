% % End of Params
% Mapper.isTransparent = false;
% Channel.isTransparent = false;
% Sig.isTransparent = false;
% Sig.beta = 0;  %Фактор спада
% Sig.span = 16; %Количество символов
% Sig.sps = 16; %Выборки на символ
% Channel.time = 0; %Значение ошибок временной синхранизации
% Channel.freq = 0.0; 
% Mapper.Type = 'DBPSK';
% Mapper.ModulationOrder = 2;
% Source.NumBitsPerFrame = 1000; %по умолчанию 1000 
% BER.BERNumRateDigits = 8;
% BER.FERNumRateDigits = 5;
% BER.BERPrecision = 5;
% BER.h2Precision = 0;
% BER.h2dBInitStep = 1;
% BER.h2dBMaxStep = 1;
% BER.h2dBMinStep = 1;
% % Отношения сигнал/шум:
% BER.h2dBInit = 0;
% BER.h2dBMax = 16;
% 
% % End of Params
% Mapper.isTransparent = false;
% Channel.isTransparent = false;
% Sig.isTransarent = false;
% Sig.beta = 1;  %Фактор спада
% Sig.span = 16; %Количество символов
% Sig.sps = 16; %Выборки на символ
% Channel.time = 0; %Значение ошибок временной синхранизации
% Channel.freq = 0.05;
% Mapper.Type = 'DBPSK';
% Mapper.ModulationOrder = 2;
% Source.NumBitsPerFrame = 1000; %по умолчанию 1000 
% BER.BERNumRateDigits = 8;
% BER.FERNumRateDigits = 5;
% BER.BERPrecision = 5;
% BER.h2Precision = 0;
% BER.h2dBInitStep = 1;
% BER.h2dBMaxStep = 1;
% BER.h2dBMinStep = 1;
% % Отношения сигнал/шум:
% BER.h2dBInit = 0;
% BER.h2dBMax = 15;
% 

% End of Params
Mapper.isTransparent = false;
Channel.isTransparent = false;
Sig.isTransparent = true;
Sig.beta = 1;  %Фактор спада
Sig.span = 16; %Количество символов
Sig.sps = 100; %Выборки на символ

Channel.time = 0; %Значение ошибок временной синхранизации
Channel.freq = 0; 
Mapper.Type = 'DQPSK';
Mapper.ModulationOrder = 4;
Source.NumBitsPerFrame = 1000; %по умолчанию 1000 
BER.BERNumRateDigits = 8;
BER.FERNumRateDigits = 5;
BER.BERPrecision = 5;
BER.h2Precision = 0;
BER.h2dBInitStep = 1;
BER.h2dBMaxStep = 1;
BER.h2dBMinStep = 1;
% Отношения сигнал/шум:
BER.h2dBInit = 0;
BER.h2dBMax = 10;

% End of Params
Mapper.isTransparent = false;
Channel.isTransparent = false;
Sig.isTransparent = true;
Sig.beta = 1;  %Фактор спада
Sig.span = 16; %Количество символов
Sig.sps = 10; %Выборки на символ
Channel.time = 0; %Значение ошибок временной синхранизации
Channel.freq = 0; 
Mapper.Type = 'DQPSK';
Mapper.ModulationOrder = 4;
Source.NumBitsPerFrame = 100; %по умолчанию 1000 
BER.BERNumRateDigits = 8;
BER.FERNumRateDigits = 5;
BER.BERPrecision = 5;
BER.h2Precision = 0;
BER.h2dBInitStep = 1;
BER.h2dBMaxStep = 1;
BER.h2dBMinStep = 1;
% Отношения сигнал/шум:
BER.h2dBInit = 0;
BER.h2dBMax = 10;

