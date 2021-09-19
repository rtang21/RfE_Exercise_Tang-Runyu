Direction = dir('D:\Runyu\RfE\TCGA-G3-AAV6\20060302\4-Body_5.0_CE');
dcm_name=ls('*.dcm');

for j=1:length(dcm_name)
% for j=1;
    
    img(:,:,j) = dicomread(dcm_name(j,:));
    dcm_number = dcm_name(j:j+5);
    info = dicominfo(dcm_number);
    info.StudyDate = '20100101';
    info.PatientSex = 'F';
    cd D:\Runyu\RfE\TCGA-G3-AAV6\20060302\4-Body_5.0_CE_tags_edited
    txt = [sprintf('dicom_image%06d.dcm',j-1)];
    dicom_img(:,:,j) = dicomwrite(img(:,:,j),txt,info);
    cd D:\Runyu\RfE\TCGA-G3-AAV6\20060302\4-Body_5.0_CE

end