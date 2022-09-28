classdef ClassMapper < handle
    properties (SetAccess = private) % ���������� �� ����������
        % ����� �� ��������� ��������� � �����������
            isTransparent;
        % ��� ����������� ���������
            Type;
        % ������ ����������� ���������
            ModulationOrder;
        % ������� ����������� ���������
            PhaseOffset;
        % ��� ����������� ��� �� ����� ����������� ���������: Binary | Gray
            SymbolMapping;
        % ������� �������� ������� � ������������� ��������: Hard decision
        % | Log-likelihood ratio | Approximate log-likelihood ratio
            DecisionMethod;
        % ���������� ���������� ������ ������ ���������� ��� ������������
            LogLanguage;
    end
    properties (SetAccess = private) % ����������� ����������
        % ������ ����� ����������� ��������� � ��������������� ��� ������
        % ���
            Constellation;
            Bits;
        % ����� ������������ ��������
            log2M;
        % ������� ��� ���������/�����������
            Mapper;
            DeMapper;
    end
    methods
        function obj = ClassMapper(Params, LogLanguage) % �����������
            % ������� ���� Params, ����������� ��� �������������
                Mapper  = Params.Mapper;
            % ������������� �������� ���������� �� ����������
                obj.isTransparent   = Mapper.isTransparent;
                obj.Type            = Mapper.Type;
                obj.ModulationOrder = Mapper.ModulationOrder;
                obj.PhaseOffset     = Mapper.PhaseOffset;
                obj.SymbolMapping   = Mapper.SymbolMapping;
                obj.DecisionMethod  = Mapper.DecisionMethod;
            % ���������� LogLanguage
                obj.LogLanguage = LogLanguage;

            % ������ ����� ������������� ��������
                obj.log2M = log2(Mapper.ModulationOrder);
            
            % ������������� ��������-�����������
                if strcmp(Mapper.Type, 'QAM')
                    obj.Mapper = comm.RectangularQAMModulator( ...
                        'ModulationOrder', Mapper.ModulationOrder, ...
                        'PhaseOffset', Mapper.PhaseOffset, ...
                        'BitInput', true, ...
                        'SymbolMapping', Mapper.SymbolMapping ...
                    );
                    obj.DeMapper = comm.RectangularQAMDemodulator( ...
                        'ModulationOrder', Mapper.ModulationOrder, ...
                        'PhaseOffset', Mapper.PhaseOffset, ...
                        'BitOutput', true, ...
                        'SymbolMapping', Mapper.SymbolMapping, ...
                        'DecisionMethod', Mapper.DecisionMethod ...
                    );
                elseif strcmp(Mapper.Type, 'PSK')
                    obj.Mapper = comm.PSKModulator( ...
                        'ModulationOrder', Mapper.ModulationOrder, ...
                        'PhaseOffset', Mapper.PhaseOffset, ...
                        'BitInput', true, ...
                        'SymbolMapping', Mapper.SymbolMapping ...
                    );
                    obj.DeMapper = comm.PSKDemodulator( ...
                        'ModulationOrder', Mapper.ModulationOrder, ...
                        'PhaseOffset', Mapper.PhaseOffset, ...
                        'BitOutput', true, ...
                        'SymbolMapping', Mapper.SymbolMapping, ...
                        'DecisionMethod', Mapper.DecisionMethod ...
                    );
%             elseif strcmp(Mapper.Type, 'DBPSK')
%                     obj.Mapper = comm.DBPSKModulator();
%                     obj.DeMapper = comm.DBPSKDemodulator();   
%                     
%                  elseif strcmp(Mapper.Type, 'DQPSK')
%                     obj.Mapper = comm.DQPSKModulator();
%                     obj.DeMapper = comm.DQPSKDemodulator();
                end

            % ��������� ������ ��������� ��� �� ����� ���������� �
            % ��������������� ������������� ��������
                if obj.isTransparent
                    obj.Bits = 1;
                    obj.Constellation = 1;
                else
                   
                    if (strcmp(obj.Type, 'QAM') || strcmp(obj.Type, 'PSK'))  
                    obj.Bits = de2bi(0:obj.ModulationOrder-1, ...
                        obj.log2M, 'left-msb').';
                    obj.Constellation = obj.Mapper.step(obj.Bits(:));
                    
                    else 
                     obj.Bits = de2bi(0:obj.ModulationOrder-1, ...
                            obj.log2M, 'left-msb').';
                            obj.Constellation = obj.Bits(:); 
                    end
                end
                
        end
        
        function OutData = StepTx(obj, InData)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            if (strcmp(obj.Type, 'QAM') || strcmp(obj.Type, 'PSK'))
            OutData = obj.Mapper.step(InData);
            elseif (strcmp(obj.Type, 'DBPSK'))
                 dbpskmod = comm.DBPSKModulator();
                    OutData = dbpskmod(InData);
                
            elseif (strcmp(obj.Type, 'DQPSK'))
                OutData = dpskmod(InData,4);
%                 dqpskmod = comm.DQPSKModulator();
%                 OutData = dqpskmod(InData);
            end
        end
        function OutData = StepRx(obj, InData, InstChannelParams)
            if obj.isTransparent
                OutData = InData;
                return
            end
            
            if ~(strcmp(obj.DecisionMethod, 'Hard decision'))
                set(obj.DeMapper, 'Variance', InstChannelParams.Variance);
            end
            if (strcmp(obj.Type, 'QAM') || strcmp(obj.Type, 'PSK')) 
                OutData = obj.DeMapper.step(InData);
            elseif (strcmp(obj.Type, 'DBPSK'))
                dbpskdemod = comm.DBPSKDemodulator();
                OutData = dbpskdemod(InData);
                
            elseif (strcmp(obj.Type, 'DQPSK'))
                OutData = dpskdemod(InData,4);
%              dqpskdemod = comm.DQPSKDemodulator();
%              OutData = dqpskdemod(InData);
            end
            end
    end
end