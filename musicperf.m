clear all, close all;

fs = 16000; % サンプリング周波数

% 楽器パラメータ（ヒント：別ファイルに定義しておき，楽器群としてインポートする方が良い）
guitar.harmonics = [1 0 1/3 0 1/5 0 1/6];
guitar.attacktime = 0.00;
guitar.decaytime = -log(0.01);

piano.harmonics = [1 -1/2 1/3 -1/4 1/5]; 
piano.attacktime = 0.0001;
piano.decaytime = -log(0.1);

organ.harmonics = [1 1/3 1/9 1/30];
organ.attacktime = 0.2;
organ.decaytime = -log(0.8);

accordion.harmonics = [1 1 1 1 1 1 1];
accordion.attacktime = 0.1;
accordion.decaytime = -log(0.8);

% 楽譜（ヒント：別ファイルに定義しておき，演奏する譜面としてインポートする方が良い）
notes = [
    
    "mi1 re-1s si-2 0.25"
    "mi1 re-1s si-2 0.5"
    "mi1 re-1s si-2 0.5"
    "do1 re-1s si-2 0.25"
    "mi1 re-1s si-2 0.5"
    "so1 so-1 mi-1 1"
    "so0 mi-1 mi-2 1"

    "do1 mi0 mi-1 0.75"
    "so0 do-1 0.75"
    "mi0 ra-2 0.75"
    "ra0 re-1 0.5"
    "si0 mi-1 0.5"
    "si0f mi-1f 0.25"
    "ra0 re-1 0.5"
    "so0 do-1 0.5"
    "mi1 ra-1 0.5"
    "so1 do-1 0.5"
    "ra1 re-1 0.5"
    "fa1 ra-1 0.35"
    "so1 do0 0.5"
    "mi1 ra-1 0.5"
    "do1 fa-1 0.25"
    "re1 so-1 0.25"
    "si0 mi-1 0.75"

    
    "do1 mi0 mi-1 0.75"
    "so0 do-1 0.75"
    "mi0 ra-2 0.75"
    "ra0 re-1 0.5"
    "si0 mi-1 0.5"
    "si0f mi-1f 0.25"
    "ra0 re-1 0.5"
    "so0 do-1 0.5"
    "mi1 ra-1 0.5"
    "so1 do-1 0.5"
    "ra1 re-1 0.5"
    "fa1 ra-1 0.35"
    "so1 do0 0.5"
    "mi1 ra-1 0.5"
    "do1 fa-1 0.25"
    "re1 so-1 0.25"
    "si0 mi-1 0.75"
    

    "ra-2 0.5"
    "so1 0.25"
    "so1f mi-1 0.25"
    "fa1 0.25"
    "re1s 0.25"
    "ra-1 0.25"
    "mi1 0.25"

    "re-1 0.25"
    "so0s 0.25"
    "ra0 0.25"
    "do1 ra-1 0.5"
    "ra0 0.25"
    "do1 re-1 0.25"
    "re1 0.25"

    "ra-2 0.5"
    "so1 0.25"
    "so1f mi-1 0.25"
    "fa1 0.25"
    "re1s 0.25"
    "ra-1 0.25"
    "mi1 re0 0.25"
    "re0 0.5"

    "fa1 so1 do2 0.5"
    "fa1 so1 do2 0.25"
    "fa1 so1 do2 0.5"
    "re0 ra-1 0.5"

    "ra-2 0.5"
    "so1 0.25"
    "so1f mi-1 0.25"
    "fa1 0.25"
    "re1s 0.25"
    "ra-1 0.25"
    "mi1 0.25"
    
    "re-1 0.25"
    "so0s 0.25"
    "ra0 0.25"
    "do1 ra-1 0.5"
    "ra0 0.25"
    "do1 re-1 0.25"
    "re1 0.25"

    "ra-2 0.5"
    "mi1f ra0f fa-1f 0.75"
    "re1 fa0 so-1f 0.75"
    "do1 mi0 ra-1 1"
    "mi-1 0.25"
    "mi-1 0.5"
    "ra-2 0.5"
    
    "ra-2 0.5"
    "so1 0.25"
    "so1f mi-1 0.25"
    "fa1 0.25"
    "re1s 0.25"
    "ra-1 0.25"
    "mi1 0.25"

    "re-1 0.25"
    "so0s 0.25"
    "ra0 0.25"
    "do1 ra-1 0.5"
    "ra0 0.25"
    "do1 re-1 0.25"
    "re1 0.25"

    
    "ra-2 0.5"
    "so1 0.25"
    "so1f mi-1 0.25"
    "fa1 0.25"
    "re1s 0.25"
    "ra-1 0.25"
    "mi1 re0 0.25"
    "re0 0.5"

    "fa1 so1 do2 0.5"
    "fa1 so1 do2 0.25"
    "fa1 so1 do2 0.5"
    "re0 ra-1 0.5"
    "ra-2 0.5"
    "so1 0.25"
    "so1f mi-1 0.25"
    "fa1 0.25"
    "re1s 0.25"
    "ra-1 0.25"
    "mi1 0.25"
    
    "re-1 0.25"
    "so0s 0.25"
    "ra0 0.25"
    "do1 ra-1 0.5"
    "ra0 0.25"
    "do1 re-1 0.25"
    "re1 0.25"

    "ra-2 0.5"
    "mi1f ra0f fa-1f 0.75"
    "re1 fa0 so-1f 0.75"
    "do1 mi0 ra-1 1"
    "mi-1 0.25"
    "mi-1 0.5"
    "ra-2 0.5"
    

    "do1 ra0f fa-2f 0.25"
    "do1 ra0f 0.5"
    "do1 ra0f do-1f 0.5"
    "do1 0.25"
    "re1 fa-1 0.5"

    %16小節
    "mi1 so0 mi-1 0.25"
    "do1 0.5"
    "ra0 ra-2 0.25"
    "so0 0.5"
    "mi-1 0.5"

    "do1 ra0f fa-2f 0.25"
    "do1 ra0f 0.5"
    "do1 ra0f do-1f 0.5"
    "do1 0.25"
    "re1 fa-1f 0.25"
    "mi1 so0 0.25"
    "mi-1 0.75"
    "ra-2 0.75"
    "mi-1 0.5"

    "do1 ra0f fa-2f 0.25"
    "do1 ra0f 0.5"
    "do1 ra0f do-1f 0.5"
    "do1 0.25"
    "re1 fa-1 0.5"

    "mi1 so0 mi-1 0.25"
    "do1 0.5"
    "ra0 ra-2 0.25"
    "so0 0.5"
    "do-1 0.5"
    

    "mi1 re-1s si-2 0.25"
    "mi1 re-1s si-2 0.5"
    "mi1 re-1s si-2 0.5"
    "do1 re-1s si-2 0.25"
    "mi1 re-1s si-2 0.5"
    "so1 so-1 mi-1 1"
    "so0 mi-1 mi-2 1"

    "do1 mi0 mi-1 0.75"
    "so0 do-1 0.75"
    "mi0 ra-2 0.75"
    "ra0 re-1 0.5"
    "si0 mi-1 0.5"
    "si0f mi-1f 0.25"
    "ra0 re-1 0.5"
    "so0 do-1 0.5"
    "mi1 ra-1 0.5"
    "so1 do-1 0.5"
    "ra1 re-1 0.5"
    "fa1 ra-1 0.35"
    "so1 do0 0.5"
    "mi1 ra-1 0.5"
    "do1 fa-1 0.25"
    "re1 so-1 0.25"
    "si0 mi-1 0.75"
    

    %二回目
    "do1 mi0 mi-1 0.75"
    "so0 do-1 0.75"
    "mi0 ra-2 0.75"
    "ra0 re-1 0.5"
    "si0 mi-1 0.5"
    "si0f mi-1f 0.25"
    "ra0 re-1 0.5"
    "so0 do-1 0.5"
    "mi1 ra-1 0.5"
    "so1 do-1 0.5"
    "ra1 re-1 0.5"
    "fa1 ra-1 0.35"
    "so1 do0 0.5"
    
    "mi1 ra-1 0.5"
    "do1 fa-1 0.25"
    "re1 so-1 0.25"
    "si0 mi-1 0.75"

    "mi1 ra0 0.25"
    "do1 0.5"
    "so0 mi0 mi-1 0.75"
    "so0s ra-1 0.5"
    "ra0 re-1 0.25"
    "fa1 0.5"
    "fa1 0.25"
    "ra0 ra-1 0.5"
    "re-1 0.5"

    "si0 si-2 0.333"
    "ra1 fa1 0.333"
    "ra1 fa1 0.333"
    %"z 1"
    "ra1 fa1 mi-1 0.333"
    "so1 0.333"
    "fa1 0.333"
    "mi1 mi-1 0.25"
    "do1 0.5"
    "ra0 0.25"
    "so0 ra-1 0.5"
    "do-1 0.5"

    "mi1 ra0 0.25"
    "do1 0.5"
    "so0 mi0 mi-1 0.75"
    "so0s ra-1 0.5"
    "ra0 re-1 0.25"
    "fa1 0.5"
    "fa1 0.25"
    "ra0 ra-1 0.5"
    "re-1 0.5"
    
    "si0 mi-1 0.25"
    "fa1 0.25"
    "z 0.25"
    "fa1 0.25"
    "fa1 mi-1 0.333"
    "mi1 fa-1 0.333"
    "re1 so-1 0.333"
    "do1 ra-1 0.5"
    "mi-1 0.5"
    "ra-2 1"
    

    "mi1 ra0 0.25"
    "do1 0.5"
    "so0 mi0 mi-1 0.75"
    "so0s ra-1 0.5"
    "ra0 re-1 0.25"
    "fa1 0.5"
    "fa1 0.25"
    "ra0 ra-1 0.5"
    "re-1 0.5"

    "si0 si-2 0.333"
    "ra1 fa1 0.333"
    "ra1 fa1 0.333"
    "ra1 fa1 mi-1 0.333"
    "so1 0.333"
    "fa1 0.333"
    "mi1 mi-1 0.25"
    "do1 0.5"
    "ra0 0.25"
    "so0 ra-1 0.5"
    "do-1 0.5"

    "mi1 ra0 0.25"
    "do1 0.5"
    "so0 mi0 mi-1 0.75"
    "so0s ra-1 0.5"
    "ra0 re-1 0.25"
    "fa1 0.5"
    "fa1 0.25"
    "ra0 ra-1 0.5"
    "re-1 0.5"
    
    "si0 mi-1 0.25"
    "fa1 0.25"
    "z 0.25"
    "fa1 0.25"
    "fa1 mi-1 0.333"
    "mi1 fa-1 0.333"
    "re1 so-1 0.333"
    "do1 ra-1 0.5"
    "mi-1 0.5"
    "ra-2 1"
        
    "do1 ra0f fa-2f 0.25"
    "do1 ra0f 0.5"
    "do1 ra0f do-1f 0.5"
    "do1 0.25"
    "re1 fa-1 0.5"

    "mi1 so0 mi-1 0.25"
    "do1 0.5"
    "ra0 ra-2 0.25"
    "so0 0.5"
    "mi-1 0.5"

    "do1 ra0f fa-2f 0.25"
    "do1 ra0f 0.5"
    "do1 ra0f do-1f 0.5"
    "do1 0.25"
    "re1 fa-1f 0.25"
    "mi1 so0 0.25"
    "mi-1 0.75"
    "ra-2 0.75"
    "mi-1 0.5"

    "do1 ra0f fa-2f 0.25"
    "do1 ra0f 0.5"
    "do1 ra0f do-1f 0.5"
    "do1 0.25"
    "re1 fa-1 0.5"

    "mi1 so0 mi-1 0.25"
    "do1 0.5"
    "ra0 ra-2 0.25"
    "so0 0.5"
    "do-1 0.5"
    
    "mi1 re-1s si-2 0.25"
    "mi1 re-1s si-2 0.5"
    "mi1 re-1s si-2 0.5"
    "do1 re-1s si-2 0.25"
    "mi1 re-1s si-2 0.5"
    "so1 so-1 mi-1 1"
    "so0 mi-1 mi-2 1"
    
    "do1 mi0 mi-1 0.5"
    "z 0.5"
    "do0 so0 do-1 0.5"
    "z 0.5"
    "mi0 so-1 ra-2 0.5"
    "z 0.5"
    "ra0 fa0 re-1 0.5"
    "si0 0.5"
    "ra0 0.5"
    "ra0f fa0 si-2f 0.5"
    "si0f 0.5"
    "ra0 0.5"
    "mi0 so0 0.5"
    "re0 so0 0.5"
    "mi0 so0 3"
    ];

% 演奏開始
instr = guitar; % 楽器を選ぶ
syn = [];
for i=notes'    % 音符を一つ一つ合成
    syn = [syn instrgen(instr, i, 0.5, fs)];
end

% 再生（ヒント：すぐに再生するよりも一旦wavファイルにセーブした方が良い）
syn = syn/max(abs(syn))*0.99;

playblocking(audioplayer(syn, fs));
