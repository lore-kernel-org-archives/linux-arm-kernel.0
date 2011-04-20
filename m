From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Apr 2011 18:41:04 +0200 (CEST)
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <20110420142816.GZ31131@pengutronix.de>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140751220.24613@xanadu.home>
	<20110414120904.GH1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140920110.24613@xanadu.home>
	<20110414153813.GC6259@n2100.arm.linux.org.uk>
	<20110418105442.GB27864@linux-sh.org>
	<20110420142816.GZ31131@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1104201830500.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> I declare this to be stable, so assuming people are OK with it, you can
> use that as a base to convert your platforms.

You declare that stable? Interesting.
 
> There is a 2nd branch on that repository that also contains my RFC patch
> just sent to this list in case you want to test it.

Which is utter crap as I pointed out a few minutes ago.

Also that clk thing is neither stable nor complete. It's just designed
wrong. 

As long as it does not handle nested clocks proper and by default w/o
your tasteless add ons, it's just moving the status quo of ARM into a
common infrastructure file.

Yes, that's probably better than not having common infrastructure at
all, but trying to build up conversions on that lot would be a
complete waste of time and resources. Simply because you need to
convert the already converted stuff another time.

Thanks,

	tglx
