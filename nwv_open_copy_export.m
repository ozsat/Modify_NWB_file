inputfile = 'E:\matlab2018\1806203fs-3.nwb';
Donor_inputFile = 'E:\matlab2018\1805102mg-2.nwb';
Output_Modified_NWB_File = 'E:\matlab2018\modifield_file.nwb'

Corrupted_Series = [1,2,3,40,53]; %% in the NWB file it starts from zero!!!!!!
Donor_Series = [1,2,3,26,27]; %% in the NWB file it starts from zero!!!!!!


nwbfile = nwbRead(inputfile);
info=h5info(inputfile);

%%
% stimulus = nwbfile.acquisition.get('index_00');
%   List_of_Series = nwbfile.acquisition.keys; %%% indexes 
%   List_of_configurations = nwbfile.acquisition.values; %%% cells that contains the whole data
%   Neurodata_type = info.Groups(1).Groups(2).Attributes(6).Value; %%% neurodata type 
%   acquisitionData = nwbfile.acquisition.get('index_00');

List_of_Series = nwbfile.acquisition.keys;%%% indexes 
Number_of_Series = size(List_of_Series,2);

%% Extract general data from nwb file
extracted.session_start_time = nwbfile.session_start_time;
extracted.identifier = nwbfile.identifier;
extracted.session_description = nwbfile.session_description;
extracted.timestamps_reference_time = nwbfile.timestamps_reference_time;

%% create the modified file with general data
nwbModified = NwbFile('session_start_time', extracted.session_start_time,...
                      'identifier', extracted.identifier,...
                      'session_description', extracted.session_description,...
                      'timestamps_reference_time', extracted.timestamps_reference_time);   
                  
%% processing of the donor file
Donor_nwbfile = nwbRead(Donor_inputFile);
Donor_info=h5info(Donor_inputFile);
Donor_List_of_Series = Donor_nwbfile.acquisition.keys; 
                  
%% start of the for loop
%  for Loopcycle = 1 : Number_of_Series
Correct_Stimulus_Cycle = 1;
Donor_Cycle = 1;
 for Loopcycle = 1 : Number_of_Series
     
%%% Open actual measurement and stumilus series     
acquisitionData = nwbfile.acquisition.get(List_of_Series{Loopcycle}); %% FOR CYCLE


%% voltage or current clamp measurement? Does it need donation?
Neurodata_type = info.Groups(1).Groups(Loopcycle).Attributes(ismember({info.Groups(1).Groups(Loopcycle).Attributes.Name},'neurodata_type')).Value

if any(Corrupted_Series(:) == Loopcycle) == 0 %%% loopcycle does not match with the series that needs to be replaced 
    disp('Not corrupt series')
    if Neurodata_type{1,1} == 'VoltageClampSeries'
        StimData = nwbfile.stimulus_presentation.get(List_of_Series{Correct_Stimulus_Cycle}); 
        disp('The neurodata_type is voltage clamp series')
        output_acquisitionData = copy_VoltageClampSeries(acquisitionData);
        output_stimData = copy_Stim_VoltageClampSeries(StimData);
         Correct_Stimulus_Cycle = Correct_Stimulus_Cycle+1;
    elseif Neurodata_type{1,1} == 'CurrentClampSeries'
        StimData = nwbfile.stimulus_presentation.get(List_of_Series{Correct_Stimulus_Cycle}); 
        disp('The neurodata_type is current clamp series')
        output_acquisitionData = copy_CurrentClampSeries(acquisitionData);
        output_stimData = copy_Stim_CurrentClampSeries(StimData);
         Correct_Stimulus_Cycle = Correct_Stimulus_Cycle+1;
    else
        disp('Unknown neurodata_type')
    end
elseif any(Corrupted_Series(:) == Loopcycle) == 1    %%%% replacement with the donor series
    disp('Corrupt series')
    if Neurodata_type{1,1} == 'VoltageClampSeries'
        StimData = Donor_nwbfile.stimulus_presentation.get(Donor_List_of_Series{Donor_Series(Donor_Cycle)}); 
        disp('The neurodata_type is voltage clamp series')
        output_acquisitionData = copy_VoltageClampSeries(acquisitionData);
        output_stimData = copy_Stim_VoltageClampSeries(StimData);
        Donor_Cycle = Donor_Cycle+1;
    elseif Neurodata_type{1,1} == 'CurrentClampSeries'
        StimData = Donor_nwbfile.stimulus_presentation.get(Donor_List_of_Series{Donor_Series(Donor_Cycle)});
        disp('The neurodata_type is current clamp series')
        output_acquisitionData = copy_CurrentClampSeries(acquisitionData);
        output_stimData = copy_Stim_CurrentClampSeries(StimData);
        Donor_Cycle = Donor_Cycle+1;
    else
        disp('Unknown neurodata_type')
    end
end


%% Pack Data 
nwbModified.acquisition.set(List_of_Series{Loopcycle},output_acquisitionData) 
nwbModified.stimulus_presentation.set(List_of_Series{Loopcycle},output_stimData)

 end
%%      Export the modified nwb file       
nwbExport(nwbModified, Output_Modified_NWB_File); 

                                            

