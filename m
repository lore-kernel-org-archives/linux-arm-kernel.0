From: paul.mckenney@linaro.org (Paul McKenney)
Date: Wed, 20 Apr 2011 21:30:43 -0000
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <alpine.LFD.2.02.1104201830500.3323@ionos>
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
	<alpine.LFD.2.02.1104201830500.3323@ionos>
Message-ID: <BANLkTink57adTtMTN5k1uPJvUtCnyUgxEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Thomas Gleixner <tglx@linutronix.de>

> On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> > I declare this to be stable, so assuming people are OK with it, you can
> > use that as a base to convert your platforms.
>
> You declare that stable? Interesting.
>
> > There is a 2nd branch on that repository that also contains my RFC patch
> > just sent to this list in case you want to test it.
>
> Which is utter crap as I pointed out a few minutes ago.
>
> Also that clk thing is neither stable nor complete. It's just designed
> wrong.
>
> As long as it does not handle nested clocks proper and by default w/o
> your tasteless add ons, it's just moving the status quo of ARM into a
> common infrastructure file.
>
> Yes, that's probably better than not having common infrastructure at
> all, but trying to build up conversions on that lot would be a
> complete waste of time and resources. Simply because you need to
> convert the already converted stuff another time.
>

Hey, guys,

Thomas's words might seem a bit harsh, but he really does understand what
Linus's reaction will be.  And Thomas's words are much less harsh than the
ones that Linus would likely choose.  I wish we had a good example of a
common-clock structure elsewhere in the kernel, but the fact is that ARM has
a much wider variety of SoCs than pretty much any other architecture.  So we
might as well get something put in place to start with that will have a
decent chance of standing the test of time (and therefore being something
that Linus is likely to approve of).

Could you please take a look at what Thomas suggested (
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/049013.html)
and give it a try?

                                                       Thanx, Paul
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110420/a84b1a97/attachment-0001.html>
