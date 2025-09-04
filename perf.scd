
~s0.play;
~s0 = { PlayBuf.ar(2, b.birds[0], startPos: rrand(0, 700000), loop: 1) * 0.2};
~s1.play;
~s1 = { PlayBuf.ar(2, b.birds[3], startPos: rrand(0, 700000), loop: 1) * 0.1};
~s2.play;
~s2 = { PlayBuf.ar(2, b.stream[0], rate: [0.9, 0.8], startPos: rrand(0, 700000), loop: 1).sum * 0.2};


~rev.play;
(
~rev = {
    var sig = [
		~s0.ar(2),
		~s1.ar(2),
		~s2.ar(2),
    ].sum;
	LPF.ar(FreeVerb.ar(sig, 0.33, 0.8, 0.5), 800, 1)
}
)

)

~bufb.play;
(
~bufb = Pbind(
    \instrument, \b,
	\buf, Pxrand(b.birds, inf),
	\rate, Pseq(([10, 12, 15] - 36), inf).midiratio,
    \dur, Prand([2, 3, 4, Rest(4)] / 4, inf),
    \atk, 0, \sus, 0.5, \rel, 0.1,
	\speed, -1,
	\amp, 0, //d -> 0.5, < 0.15
    \db, -20, // < -20
)
)

~bufs.play;
(
~bufs = Pbind(
    \instrument, \b,
	\buf, Prand([b.stream, Rest(2)], inf),
	\dur, Prand([1, 1, 1, 1, 2, 2, 4, 4] / 4, inf),
    \rate, Pwhite(-5, 2.0).midiratio,
    \rel, 10,
	\atk, 0, \sus, 0.5, \rel, 0.5,
	\speed, -1,
	\amp, 0, //d -> 0.5, < 0.08
    \db, -10,   //< -10
)
)

~wn.play;
(
~wn = Pbind(
    \instrument, \wn,
    \dur, Prand([1/8, Rest(1/8)], inf),
    \pan, Pseq((-10..10).mirror/10, inf),
	\freq, Prand(([16000, 12000, 8500] - 0), inf),
    \rq, 0.2, //< 0.2
    \atk, 0, \sus, 0.1, \rel, 0.2,
	\amp, 0, //d -> 0.1
    \db, -20, //< -20
)
)

~p0.play;
(
~p0 = Pbind(
    \instrument, \imp,
    \dur, Prand([
        Pseq([1/8], 8),
        Pseq([2], 1),
    ], inf),
    \pan, 0,
    \freq, Pwhite(14000, 15500),
    \atk, 0, \sus, 0.02, \rel, 0,
	\amp, 0, //d -> 0.2, < 0.06
	\db, -20, //< -20
);
)

~p1.play;
(
~p1 = Pbind(
    \instrument, \saw,
	\dur, 8,
    \midinote,
    Pseq([
		Pseq([47, 52, 54, 61], 4),
		Pseq(([47, 52, 54, 61] - 14), 4),
		// [47, 52, 54, 61]
		// [60, 64, 67, 71, 74]
    ], inf),
	\cutoffmax, Pwhite(400, 800, inf), // < 3000
	\amp, 0, //d -> 0.2, < 0.03
    \db, -20,
)
)


~b0.play;
(
~b0 = Pbind(
    \instrument, \plu,
    \dur, Prand([1, Rest(1)] / 4, inf),
	\freq, (Pexprand(1, 100) * (40)),
    \atk, 0, \sus, 2, \rel, 4,
	\amp, 0, //d -> 0.1, < 0.5
	\db, 5, //< 5
)
)

~b1.play;
(
~b1 = Pbind(
    \instrument, \aco,
    \degree, Pfunc({ (-2..2).scramble.keep(rrand(1, 2)) }),
    #[atk, sus, rel], Pfunc({ [4, 0, 4] }),
    \lpf, 1000,
    \dur, Pexprand(0.2, 10).round(0.25),
	\amp, 0, //d -> 0.1 ,< 1
    \db, 5, //< 5
)
)

~k0.play;
(
~k0 = Pbind(
    \instrument, \kick,
	/*\dur, 1/8,*/
	\dur, Pwrand([0.5, 0.25, 0.125, Rest(0.125), Rest(0.25)],
		[0.2, 0.2, 0.2, 0.2, 0.2], inf),
    /*\freq, Pseq([
		440, 800, \, \,
		\, \, \, \,
		440, \, \, \,
		\, \, \, \,
	], inf),*/
	\freq, Pexprand(240, 1000, inf),
    \rel, 1,
	\amp, 0, //d->0.1, < 0.15
	\db, -10, //<-15
)
)

~h0.play;
(
~h0 = Pbind(
    \instrument, \hat,
    \dur, 1/8,
	\freq, Pseq([
		\, 1, \, \,
		\, 1, \, \,
		\, 1, \, \,
		\, 1, \, \,
	], inf),
    \rel, Pwhite(1, 0.5),
	\amp, 0, //d -> 0.6
    \db, -10,
)
)
