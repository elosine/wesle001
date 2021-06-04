(
s.options.numInputBusChannels = 4;
s.options.memSize_(65536 * 8);
s.waitForBoot{
	m = ServerMeter.new(s, 4, 2);
	SynthDef(\wesle001, {
		arg outChannel = 0, inCh = 2, masterAmp=1, iMidi=55, decay=1.0, filterAmp=2.9;
		var src, p1, p2, p3, p4, p5, p6, p7,p8,p9,p10, finalSignalL, finalSignalR, iFreq;
		var freqOsc1 = SinOsc.ar(0.05).cpsmidi*0.081;
		var freqOsc2 = SinOsc.ar(0.065).cpsmidi*0.0812;
		var freqOsc3 = SinOsc.ar(0.07).cpsmidi*0.09;
		var freqOsc4 = SinOsc.ar(0.083).cpsmidi*0.0913;
		var freqOsc5 = SinOsc.ar(0.097).cpsmidi*0.09102;
		var freqOsc6 = SinOsc.ar(0.041).cpsmidi*0.08;
		var freqOsc7 = SinOsc.ar(0.053).cpsmidi*0.086;
		var freqOsc8 = SinOsc.ar(0.066).cpsmidi*0.094;
		var freqOsc9 = SinOsc.ar(0.078).cpsmidi*0.0711;
		var freqOsc10 = SinOsc.ar(0.082).cpsmidi*0.0714;
		iFreq = iMidi.midicps;
		src = SoundIn.ar(inCh);
		p1 = ComplexRes.ar(src,(iFreq*2)+freqOsc1,decay);
		p2 = ComplexRes.ar(src,(iFreq*3)+freqOsc2,decay);
		p3 = ComplexRes.ar(src,(iFreq*4)+freqOsc3,decay);
		p4 = ComplexRes.ar(src,(iFreq*5)+freqOsc4,decay);
		p5 = ComplexRes.ar(src,(iFreq*6)+freqOsc5,decay);
		p6 = ComplexRes.ar(src,(iFreq*7)+freqOsc6,decay);
		p7 = ComplexRes.ar(src,(iFreq*8)+freqOsc7,decay);
		p8 = ComplexRes.ar(src,(iFreq*9)+freqOsc8,decay);
		p9 = ComplexRes.ar(src,(iFreq*10)+freqOsc9,decay);
		p10 = ComplexRes.ar(src,(iFreq*11)+freqOsc10,decay);
		finalSignalL = Mix.ar([
			p1*filterAmp, p2*filterAmp*2,
			p3*filterAmp*3, p4*filterAmp*4,
			p5*filterAmp*5, p6*filterAmp*6,
			p7*filterAmp*7, p8*filterAmp*8,
			p9*filterAmp*9, p10*filterAmp*10
		]);
		finalSignalR = DelayC.ar(finalSignalL, delaytime:0.01);
		Out.ar(outChannel, [finalSignalL,finalSignalR]*masterAmp);
	}).add;
})
y = Synth.new(\wesle001);
y.set(\filterAmp,2.9)
y.set(\masterAmp, 1)
y.free;


OSCdef(\p1, {|msg, time, addr, recvPort| msg.postln}, '/p1');
OSCdef(\p2, {|msg, time, addr, recvPort| msg.postln}, '/p2');
OSCdef(\p3, {|msg, time, addr, recvPort| msg.postln}, '/p3');
OSCdef(\p4, {|msg, time, addr, recvPort| msg.postln}, '/p4');
NetAddr.langPort