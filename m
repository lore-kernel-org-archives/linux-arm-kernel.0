From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 14 Apr 2011 19:20:17 +0200
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <20110414153813.GC6259@n2100.arm.linux.org.uk>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140751220.24613@xanadu.home>
	<20110414120904.GH1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140920110.24613@xanadu.home>
	<20110414153813.GC6259@n2100.arm.linux.org.uk>
Message-ID: <20110414172017.GD31990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Apr 14, 2011 at 04:38:14PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 14, 2011 at 09:39:58AM -0400, Nicolas Pitre wrote:
> Now, the next thing is that Linus hasn't been too happy about driver stuff
> coming via my tree either - it's something which has been the subject of
> concern in private email.  I've _already_ said something about that prior
> to the recent merge window.  So should I take the clk API stuff which
> touches the drivers subtree?  If yes, it needs to be kept entirely separate
> from the rest of the ARM stuff so we don't end up mixing drivers stuff with
> ARM stuff.
OK, so the solution is to put this in a seperate branch. But then when
platform maintainers start working with it the resulting changes will
most probably go to arch/arm. So if Linus doesn't want to pull a tree
that touches both drivers/clk and arch/arm, then either he has to pull
the clk branch first or we have to wait for the next merge window until
we can use it.

I prefer the former.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
