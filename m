From: balbi@ti.com (Felipe Balbi)
Date: Wed, 5 Jan 2011 08:51:25 +0200
Subject: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
In-Reply-To: <20110104205445.GF25121@pengutronix.de>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
	<1294142577-28772-3-git-send-email-balbi@ti.com>
	<20110104140031.GE25121@pengutronix.de>
	<20110104173301.GA25976@n2100.arm.linux.org.uk>
	<20110104205445.GF25121@pengutronix.de>
Message-ID: <20110105065124.GD2458@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 04, 2011 at 09:54:45PM +0100, Uwe Kleine-K?nig wrote:
> > If you look at kernel/irq/Kconfig (as I did with the original patch)
> > you'd notice kernel/irq/Kconfig defines both of these symbols being
> > removed when HAVE_GENERIC_HARDIRQS is enabled.
> > 
> > If you read the discussion in the previous version of this patch set,
> > you'd notice that the removal of this was specifically requested.
> > 
> > It's very tiresome to have to re-explain these things.  Please take
> > some more time to research the points you bring up, rather than
> I don't agree here 100%.  IMHO the commit log was not good enough for
> the change introduced by the patch (and Felipe's reply suggests that he
> agrees).  I could still research it, but:
> 
>  - it was not obvious for me there was a previous version (no "v2" or
>    similar in the patch subject);
>  - for me it would take say 5 minutes to check, the author knows
>    the answer to my question immediately (at least he should);
>  - after a research I could suggest a better wording, but I don't care
>    much if it's me or Felipe who comes up with a better text.
> 
> So all in all I'm still confident that my mail was OK.

No need to fight over a simple change, here it is updated.

-- 
balbi
