From: mingo@elte.hu (Ingo Molnar)
Date: Sun, 29 May 2011 22:17:13 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <1306345402.21578.100.camel@twins>
References: <20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
	<alpine.LFD.2.02.1105242239230.3078@ionos>
	<20110525150153.GE29179@elte.hu> <1306345402.21578.100.camel@twins>
Message-ID: <20110529201713.GA25789@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> But face it, you can argue until you're blue in the face,

That is not a technical argument though - and i considered and 
answered every valid technical argument made by you and Thomas.
You were either not able to or not willing to counter them.

> [...] but both tglx and I will NAK any and all patches that extend 
> perf/ftrace beyond the passive observing role.

The thing is, perf is *already* well beyond the 'passive observer' 
role: we already generate lots of 'action' in response to events. We 
generate notification signals, we write events - all of which can 
(and does) modify program behavior.

So what's your point? There's no "passive observer" role really - 
it's apparently just that you dislike this use of instrumentation 
while you approve of other uses.

Thanks,

	Ingo
