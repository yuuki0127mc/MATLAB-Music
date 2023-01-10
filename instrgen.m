function sig = instrgen(instr, scale, speed, fs)
%
%
%

% 音符テキストを構成する音階と時間長に分解しリスト化
scale = split(scale);

% 音符の長さを取り出す
dur = str2num(scale(end));
scale(end) = [];

% 中央のC（ド）
fc = 261.6;

% 演奏する
t = [0:fs*speed*dur] / fs;  % 信号波形の時刻情報
sig = zeros(size(t));       % 信号波形用配列確保

for s = scale'
    sc = char(s);
    n = 0;

    % シャープとフラットの解釈
    lastletter = sc(end);
    if lastletter == 's'
        n = n + 1;
        sc(end) = [];
    elseif lastletter == 'f'
        n = n - 1;
        sc(end) = [];
    end

    % オクターブの解釈
    lastletter = sc(end);
    if lastletter >= '0' & lastletter <= '9'
        if sc(end-1) == '-'
            n = n - 12 * str2num(lastletter);
            sc(end) = [];
        else
            n = n + 12 * str2num(lastletter);
        end
        sc(end) = [];
    end

    % ドレミファ...の解釈
    m = 0;
    switch sc
        case 'do'
            m = 0;
        case 're'
            m = 2;
        case 'mi'
            m = 4;
        case 'fa'
            m = 5;
        case 'so'
            m = 7;
        case 'ra'
            m = 9;
        case 'si'
            m = 11;
        otherwise
            sc
            m = 100;
    end
        n = n + m;

        switch sc
            case 'z'
                fc = 0;
        end
        

    % 音色合成
    for i = 1:length(instr.harmonics)
        sig = sig + instr.harmonics(i) * sin(2 * pi * i * fc * (2^(n/12)) * t);
    end
end

% 信号波形の立ち上がり部の整形
nsmpl = floor(instr.attacktime * fs);
siglen = length(sig);
if nsmpl > siglen
    nsmpl = siglen;
end
sig(1:nsmpl) = sig(1:nsmpl) .* [0:1/(nsmpl-1):1];

% 信号波形の包絡減衰付与
sig = sig .* exp(-instr.decaytime * t);

return
