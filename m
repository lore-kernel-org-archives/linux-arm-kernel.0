From: peterz@infradead.org (Peter Zijlstra)
Date: Sun, 25 Apr 2010 16:36:14 +0200
Subject: Q: sched_clock() vs. clocksource, how to implement correctly
In-Reply-To: <20100424205011.GA21632@sig21.net>
References: <20100423150917.GA25714@sig21.net>
	<20100423182933.0df45b53@mschwide.boeblingen.de.ibm.com>
	<20100424205011.GA21632@sig21.net>
Message-ID: <1272206174.5289.1.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-04-24 at 22:50 +0200, Johannes Stezenbach wrote:
> Somehow I got the impression that cnt32_to_63() is old-style,

Not really, the biggest problem it has is that is not SMP aware. I did
some patches for that at one time, but people objected for some reason.
