function output_acquisitionData = copy_VoltageClampSeries (input_acquisitionData)

%%% imput_acquisitionData: single index_xx from the nwb file 
%%% output_acquisitionData: uncompressed nwb data, that contains the parameters 

acquisitionData = input_acquisitionData;

%% ADATOK KISZEDÉSE
extracted.capacitance_fast_unit = acquisitionData.capacitance_fast_unit;
extracted.capacitance_slow_unit = acquisitionData.capacitance_slow_unit;
extracted.resistance_comp_bandwidth_unit = acquisitionData.resistance_comp_bandwidth_unit;
extracted.resistance_comp_correction_unit = acquisitionData.resistance_comp_correction_unit;
extracted.resistance_comp_prediction_unit = acquisitionData.resistance_comp_prediction_unit;
extracted.whole_cell_capacitance_comp_unit = acquisitionData.whole_cell_capacitance_comp_unit;
extracted.capacitance_fast = acquisitionData.capacitance_fast;
extracted.capacitance_slow = acquisitionData.capacitance_slow;
extracted.resistance_comp_bandwidth = acquisitionData.resistance_comp_bandwidth;
extracted.resistance_comp_correction = acquisitionData.resistance_comp_correction;
extracted.resistance_comp_prediction = acquisitionData.resistance_comp_prediction;
extracted.whole_cell_capacitance_comp = acquisitionData.whole_cell_capacitance_comp;
extracted.whole_cell_series_resistance_comp = acquisitionData.whole_cell_series_resistance_comp;

extracted.electrode = acquisitionData.electrode;
extracted.gain = acquisitionData.gain;
extracted.stimulus_description = acquisitionData.stimulus_description;
extracted.sweep_number = acquisitionData.sweep_number;
extracted.starting_time_unit = acquisitionData.starting_time_unit;
extracted.timestamps_interval = acquisitionData.timestamps_interval;
extracted.timestamps_unit = acquisitionData.timestamps_unit;
extracted.comments = acquisitionData.comments;
extracted.control = acquisitionData.control;
extracted.control_description = acquisitionData.control_description;
% extracted.data = acquisitionData.data; %%
extracted.data_conversion = acquisitionData.data_conversion;
extracted.data_resolution = acquisitionData.data_resolution;
extracted.data_unit = acquisitionData.data_unit;
extracted.description = acquisitionData.description;
extracted.starting_time = acquisitionData.starting_time;
extracted.starting_time_rate = acquisitionData.starting_time_rate;
extracted.timestamps = acquisitionData.timestamps;

%% compress and write 2nd attempt
RawStimData = acquisitionData.data.load;

fData_compressed=types.untyped.DataPipe('data', RawStimData.');

output_acquisitionData = types.core.VoltageClampSeries(...
                                                'capacitance_fast_unit', extracted.capacitance_fast_unit,...
                                                'capacitance_slow_unit', extracted.capacitance_slow_unit,...
                                                'resistance_comp_bandwidth_unit', extracted.resistance_comp_bandwidth_unit,...
                                                'resistance_comp_correction_unit', extracted.resistance_comp_correction_unit,...
                                                'resistance_comp_prediction_unit', extracted.resistance_comp_prediction_unit,...
                                                'whole_cell_capacitance_comp_unit', extracted.whole_cell_capacitance_comp_unit,...
                                                'capacitance_fast', extracted.capacitance_fast,...
                                                'capacitance_slow', extracted.capacitance_slow,...
                                                'resistance_comp_bandwidth', extracted.resistance_comp_bandwidth,...
                                                'resistance_comp_correction', extracted.resistance_comp_correction,...
                                                'resistance_comp_prediction', extracted.resistance_comp_prediction,...
                                                'whole_cell_capacitance_comp', extracted.whole_cell_capacitance_comp,...
                                                'whole_cell_series_resistance_comp', extracted.whole_cell_series_resistance_comp,...
                                                'electrode', extracted.electrode, ...
                                                'gain', extracted.gain, ...
                                                'stimulus_description', extracted.stimulus_description, ...
                                                'sweep_number', extracted.sweep_number, ...
                                                'starting_time_unit', extracted.starting_time_unit, ...
                                                'timestamps_interval', extracted.timestamps_interval, ...
                                                'timestamps_unit', extracted.timestamps_unit, ...
                                                'comments', extracted.comments, ...
                                                'control', extracted.control, ...
                                                'control_description', extracted.control_description, ...
                                                'data_conversion', extracted.data_conversion, ...
                                                'data_resolution', extracted.data_resolution, ...
                                                'data_unit', extracted.data_unit, ...
                                                'description', extracted.description, ...
                                                'starting_time', extracted.starting_time, ...
                                                'starting_time_rate', extracted.starting_time_rate, ...
                                                'timestamps', extracted.timestamps,...
                                                'data', fData_compressed);
                                                        
                           

end