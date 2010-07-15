From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 12:53:58 +0100
Subject: [PATCH 1/3] ARM: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <AANLkTinxE6hbgVWqvxen6yDNM1VLgK2DFnMyN_o_zbsw@mail.gmail.com>
References: <1278429668-4564-1-git-send-email-triad@df.lth.se>
	<20100715102237.GI26212@n2100.arm.linux.org.uk>
	<AANLkTinxE6hbgVWqvxen6yDNM1VLgK2DFnMyN_o_zbsw@mail.gmail.com>
Message-ID: <20100715115358.GF29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 01:49:28PM +0200, Linus Walleij wrote:
> 2010/7/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > I think the only questionable thing on this is the location of the
> > driver. ?As we now have plat-versatile for the shared stuff between
> > integrator, verastile, realview and versatile express, maybe it'd
> > make more sense to be in plat-versatile?
> 
> OK I can move it there.
> 
> > Or maybe drivers/platform/arm/ (to avoid Linus' complaint about
> > drivers under arch/ ?)
> 
> Creating that for a single driver seems weird, I could just as well
> create drivers/lcd for all LCDs in that case. But there is another
> LCD-like driver for a USB-connected LCD under drivers/misc
> IIRC, maybe I can make a patch for that as well and let the misc
> maintainer decide if he wants it.

My first preference would be somewhere under drivers/, if not then
plat-versatile.  So if you think drivers/misc would be suitable,
please try the misc maintainer.
