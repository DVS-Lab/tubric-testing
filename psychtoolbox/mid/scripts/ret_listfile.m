rand('state', sum(100*clock));
clear all;
close all;
    
stimsa12 = {'a01'; 	'a02'; 	'a03'; 	'a04'; 	'a05'; 	'a06'; 	'a07'; 	'a08'; 	'a09'; 	'a10'; 	'a11'; 	'a12'; 	'a13'; 	'a14'; 	'a15'; 'a16'; 	'a17'; 	'a18'; 	'a19'; 	'a20'; 	'a21'; 	'a22'; 	'a23'; 	'a24'; 	'a25'; 	'a26'; 	'a27'; 	'a28'; 	'a29'; 	'a30'};
stimsb12 = {'b01'; 	'b02'; 	'b03'; 	'b04'; 	'b05'; 	'b06'; 	'b07'; 	'b08'; 	'b09'; 	'b10'; 	'b11'; 	'b12'; 	'b13'; 	'b14'; 	'b15'; 'b16'; 	'b17'; 	'b18'; 	'b19'; 	'b20'; 	'b21'; 	'b22'; 	'b23'; 	'b24'; 	'b25'; 	'b26'; 	'b27'; 	'b28'; 	'b29'; 	'b30'};
stimsa34 = {'a31'; 	'a32'; 	'a33'; 	'a34'; 	'a35'; 	'a36'; 	'a37'; 	'a38'; 	'a39'; 	'a40'; 	'a41'; 	'a42'; 	'a43'; 	'a44'; 	'a45'; 'a46'; 	'a47'; 	'a48'; 	'a49'; 	'a50'; 	'a51'; 	'a52'; 	'a53'; 	'a54'; 	'a55'; 	'a56'; 	'a57'; 	'a58'; 	'a59'; 	'a60'};
stimsb34 = {'b31'; 	'b32'; 	'b33'; 	'b34'; 	'b35'; 	'b36'; 	'b37'; 	'b38'; 	'b39'; 	'b40'; 	'b41'; 	'b42'; 	'b43'; 	'b44'; 	'b45'; 'b46'; 	'b47'; 	'b48'; 	'b49'; 	'b50'; 	'b51'; 	'b52'; 	'b53'; 	'b54'; 	'b55'; 	'b56'; 	'b57'; 	'b58'; 	'b59'; 	'b60'};
stimFOIL = {'c01'; 'c02';  'c03';  'c04';  'c05';  'c06';  'c07';  'c08';  'c09';  'c10';  'c11';  'c12';  'c13';  'c14';  'c15'; 'c16'; 'c17'; 'c18'; 'c19'; 'c20'; 'c21'; 'c22'; 'c23'; 'c24'; 'c25'; 'c26'; 'c27'; 'c28'; 'c29'; 'c30'; 'd01';    'd02';  'd03';  'd04';  'd05';  'd06';  'd07';  'd08';  'd09';  'd10';  'd11';  'd12';  'd13';  'd14';  'd15'; 'd16';   'd17';  'd18';  'd19';  'd20';  'd21';  'd22';  'd23';  'd24';  'd25';  'd26';  'd27';  'd28';  'd29';  'd30'; 'c31'; 	'c32'; 	'c33'; 	'c34'; 	'c35'; 	'c36'; 	'c37'; 	'c38'; 	'c39'; 	'c40'; 	'c41'; 	'c42'; 	'c43'; 	'c44'; 	'c45'; 'c46'; 	'c47'; 	'c48'; 	'c49'; 	'c50'; 	'c51'; 	'c52'; 	'c53'; 	'c54'; 	'c55'; 	'c56'; 	'c57'; 	'c58'; 	'c59'; 	'c60'; 'd31'; 	'd32'; 	'd33'; 	'd34'; 	'd35'; 	'd36'; 	'd37'; 	'd38'; 	'd39'; 	'd40'; 	'd41'; 	'd42'; 	'd43'; 	'd44'; 	'd45'; 'd46'; 	'd47'; 	'd48'; 	'd49'; 	'd50'; 	'd51'; 	'd52'; 	'd53'; 	'd54'; 	'd55'; 	'd56'; 	'd57'; 	'd58'; 	'd59'; 	'd60'};

for subj = 1:40
ret1list = {};
ret2list = {};
[stimsa12 index] = Shuffle(stimsa12);
[stimsa34 index] = Shuffle(stimsa34);
[stimsb12 index] = Shuffle(stimsb12);
[stimsb34 index] = Shuffle(stimsb34);
[stimFOIL index] = Shuffle(stimFOIL);
    
ret1list.a = {stimsa12{1:15}, stimsa34{1:15}} ;
ret1list.b = {stimsb12{1:15}, stimsb34{1:15}} ;
ret1list.c = {stimFOIL{1:60}};
ret2list.a = {stimsa12{16:30}, stimsa34{16:30}} ;
ret2list.b = {stimsb12{16:30}, stimsb34{16:30}} ;
ret2list.c = {stimFOIL{61:120}};

save([num2str(subj) 'ret1input'], 'ret1list')  ;
save([num2str(subj) 'ret2input'], 'ret2list')  ;  

end
clear all;
close all;
