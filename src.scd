s.boot;
s.quit;
s.freeAll;
s.reboot;
s.freqscope; s.scope; s.meter;

(
var basePath;

p = ProxySpace(s, clock: TempoClock(1, queueSize: 1024)).quant_(4).fadeTime_(8).push;
// ProxyMixer(p);

SynthDef(\saw, {
	arg out=0, atk=5, sus=0, rel=4,
	freq=500, cf=1500, cutoffmax=1400, amp=0.2, gate=1;
	var env, voices, cutoff, sig;

	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel]), gate, doneAction:2);

	voices = Mix.fill(4, {
		var pan = Rand(-0.9, 0.9);
		var det = Rand(-1.0, 1.0);
		Pan2.ar(Saw.ar(Lag.kr(freq + det, 0.03)), pan);
	});

	cutoff = Lag.kr(SinOsc.kr(0.1).range(600, cutoffmax), 0.05);
	sig = RLPF.ar(voices, cutoff, 0.4) * env * amp;
	Out.ar(out, sig);
}).add;

SynthDef(\kick, {
    arg out=0, freq = 440, rel = 0.4, amp = 0.1;
    var sig, pitchenv, ampenv;
    pitchenv = EnvGen.kr(Env([freq, 70, 50], [0.01, rel]), doneAction:2);
    ampenv = EnvGen.kr(Env.perc(0.01, rel, 1, -8), doneAction:2);
    sig = SinOsc.ar(pitchenv) * ampenv;
    sig = (sig!2) * amp;
    Out.ar(out, sig);
}).add;

SynthDef(\hat, {
    arg out=0, freq, rel=0.03, amp=0.6;
    var sig, env;
    sig = BPF.ar(WhiteNoise.ar(0.2), 9000, 0.1);
    env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
    sig = (sig!2 * env) * amp;
    Out.ar(out, sig);
}).add;

SynthDef(\plu, { |out=0, freq=440, amp=0.1, pan=0, atk=0, sus=0, rel=1, coef=0.8|
	var env = EnvGen.kr(Env.linen(atk, sus, rel, amp), doneAction:2);
	var sig = Pluck.ar(
		in: WhiteNoise.ar(0.2),
		trig: 1,
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: rel,
		coef: coef
	);
	Out.ar(out, Pan2.ar(sig * env, pan));
}).add;




SynthDef(\wn, { |out=0, freq=12000, rq=0.5, amp=0.1, pan=0, atk=0, sus=0.002, rel=0.02|
	var env = EnvGen.kr(Env.linen(atk, sus, rel, amp), doneAction:2);
	var sig = WhiteNoise.ar * env;
	sig = BPF.ar(sig, freq, rq);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\k, { |out=0, freq=50, amp=0.05, pan=0, atk=0.001, rel=1|
	var env = EnvGen.kr(Env.perc(atk, rel, amp), doneAction:2);
	var pitchEnv = EnvGen.kr(Env([freq*4, freq], [rel], \exp));
	var sig = SinOsc.ar(pitchEnv) * env;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;


SynthDef(\imp, { |out=0, freq=1000, amp=0.2, pan=0, atk=0, sus=0.01, rel=0|
	var env = EnvGen.kr(Env.linen(atk, sus, rel, amp), doneAction:2);
	var sig = SinOsc.ar(freq) * env;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\aco, { |out=0, freq=440, amp=0.1, pan=0, atk=0, sus=0, rel=4, coef=0.5, lpf=2000|
	var env = EnvGen.kr(Env.linen(atk, sus, rel, amp), doneAction:2);
	var sig = Pluck.ar(
		in: PinkNoise.ar(0.3),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: rel,
		coef: coef
	);
	sig = LPF.ar(sig, lpf) * env * 20;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;




SynthDef(\b, { |out=0, buf=5, rate=1, amp=0.5, pan=0, atk=0, sus=2, rel=2|
	var env = EnvGen.kr(Env.linen(atk, sus, rel, amp), doneAction:2);
	var sig = PlayBuf.ar(
		2, buf,
		rate * BufRateScale.kr(buf),
		startPos:rrand(0, BufFrames.kr(buf)),
		loop:0
	);
	Out.ar(out, Pan2.ar(sig * env, pan));
}).add;




// var basePath;
b = ();

basePath = "C:/Users/kanat/OneDrive/デスクトップ/SuperCollider/ambient/sample/";

b.birds = [
    Buffer.read(s, basePath ++ "field_birds_1.wav"),
	Buffer.read(s, basePath ++ "field_birds_2.wav"),
	Buffer.read(s, basePath ++ "field_birds_3.wav"),
	Buffer.read(s, basePath ++ "field_birds_4.wav"),
	Buffer.read(s, basePath ++ "field_birds_5.wav"),
];

b.stream = [
    Buffer.read(s, basePath ++ "stream_1.wav",
		100000, action:{ |buf| buf.normalize(1);}),
	Buffer.read(s, basePath ++ "stream_2.wav"),
	Buffer.read(s, basePath ++ "stream_3.wav"),
];
)
