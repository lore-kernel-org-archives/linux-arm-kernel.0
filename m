From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Mar 2013 20:09:32 +0800
Subject: [PATCH v5 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
In-Reply-To: <1364373790.5442.5.camel@pizza.hi.pengutronix.de>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
 <20130326181909.GA31593@amd.pavel.ucw.cz>
 <201303262213.39068.marex@denx.de>
 <1364373790.5442.5.camel@pizza.hi.pengutronix.de>
Message-ID: <20130327120930.GB2674@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 09:43:10AM +0100, Philipp Zabel wrote:
> > > Series looks mostly ok to me. (Should the last patch be actually
> > > first, so that reset functionality is kept between 5/8 and 8/8?)
> > 
> > Not first, but rather third.
> > 
> > You can add my
> > Reviewed-by: Marek Vasut <marex@denx.de>
> 
> The gpio-reset driver is not used yet, so there are no ordering
> limitations. Still, grouping them together as you suggest sounds
> sensible to me.

Yea, I think we should try to get those three patches in first.  I guess
you can try ask Greg or Arnd to handle the patches.

Shawn
