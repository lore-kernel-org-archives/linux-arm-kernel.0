From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 26 Oct 2012 21:25:59 +0000 (UTC)
Subject: [PATCH] ARM: OMAP1: usb: fix sparse warnings
In-Reply-To: <20121026212059.GV11908@atomide.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com>
 <20121026212059.GV11908@atomide.com>
Message-ID: <alpine.DEB.2.00.1210262125410.11258@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [121026 13:54]:
> > 
> > Resolve the following sparse warnings:
> > 
> > arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was not declared. Should it be static?
> > arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was not declared. Should it be static?
> > arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was not declared. Should it be static?
> > 
> > by declaring those functions as static.  Also remove the unneeded
> > prototypes and related code from the plat/usb.h header file.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > Tony, care to take this one?
> 
> Let's apply just the usb.c changes on omap-for-v3.8/cleanup-headers
> as plat/usb.h is now gone?

OK no problem, thought you might want it for the -rc series...

- Paul
