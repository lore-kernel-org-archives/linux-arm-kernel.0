From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 4 Jan 2011 21:54:45 +0100
Subject: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
In-Reply-To: <20110104173301.GA25976@n2100.arm.linux.org.uk>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
	<1294142577-28772-3-git-send-email-balbi@ti.com>
	<20110104140031.GE25121@pengutronix.de>
	<20110104173301.GA25976@n2100.arm.linux.org.uk>
Message-ID: <20110104205445.GF25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 04, 2011 at 05:33:01PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 04, 2011 at 03:00:31PM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Jan 04, 2011 at 02:02:55PM +0200, Felipe Balbi wrote:
> > > @@ -171,9 +168,6 @@ config FIQ
> > >  config ARCH_MTD_XIP
> > >  	bool
> > >  
> > > -config GENERIC_HARDIRQS_NO__DO_IRQ
> > > -	def_bool y
> > > -
> > You didn't mention this change in the commit log.  Is this duplicated,
> > too or did it just slip through?
> 
> If you look at kernel/irq/Kconfig (as I did with the original patch)
> you'd notice kernel/irq/Kconfig defines both of these symbols being
> removed when HAVE_GENERIC_HARDIRQS is enabled.
> 
> If you read the discussion in the previous version of this patch set,
> you'd notice that the removal of this was specifically requested.
> 
> It's very tiresome to have to re-explain these things.  Please take
> some more time to research the points you bring up, rather than
I don't agree here 100%.  IMHO the commit log was not good enough for
the change introduced by the patch (and Felipe's reply suggests that he
agrees).  I could still research it, but:

 - it was not obvious for me there was a previous version (no "v2" or
   similar in the patch subject);
 - for me it would take say 5 minutes to check, the author knows
   the answer to my question immediately (at least he should);
 - after a research I could suggest a better wording, but I don't care
   much if it's me or Felipe who comes up with a better text.

So all in all I'm still confident that my mail was OK.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
