cd 'D:\Runyu\RfE\TCGA-G3-AAV6\20060302\4-Body_5.0_CE';
dcm_name=ls('*.dcm');

for j=1:length(dcm_name)
    
    img(:,:,j) = dicomread(dcm_name(j,:)); %read dicom image
    info = dicominfo(dcm_name(j,:)); %obtain dicom tags
    info.StudyDate = '20100101'; %change the tag StudyDate to 20100101
    info.PatientSex = 'F'; %change the tag PatientSex to Female
    cd D:\Runyu\RfE\TCGA-G3-AAV6\20060302\4-Body_5.0_CE_tags_edited
    txt = [sprintf('dicom_image%06d.dcm',j-1)];
    dicom_img(:,:,j) = dicomwrite(img(:,:,j),txt,info); %save dicom dump
    cd D:\Runyu\RfE\TCGA-G3-AAV6\20060302\4-Body_5.0_CE %return to folder contains dicom data

end