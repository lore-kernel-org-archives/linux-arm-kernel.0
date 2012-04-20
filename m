From: marex@denx.de (Marek Vasut)
Date: Fri, 20 Apr 2012 02:56:50 +0200
Subject: [PATCH 05/10] MXS: Add platform registration hooks for USB EHCI
In-Reply-To: <20120420004011.GF22219@S2101-09.ap.freescale.net>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <201204192332.56957.marex@denx.de>
 <20120420004011.GF22219@S2101-09.ap.freescale.net>
Message-ID: <201204200256.51011.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Thu, Apr 19, 2012 at 11:32:56PM +0200, Marek Vasut wrote:
> > The Device Tree code for MXS is not ripe yet. We still miss a lot in
> > there. Flipping this usb stuff to DT should be easy, I see no point
> > disallowing this (and that stands also for the MXS SPI actually) into
> > kernel so more people can test it only because you'd like this to wait
> > for who knows how long for the DT support to arrive. Don't take it
> > personally, but I still believe it's too early to enforce DT on MXS.
> 
> Let me put it another way.  When you have drivers/usb changes hit
> mainline, while there is still something not ripe for mxs DT support
> while stops you adding DT support for usb driver, you have good reason
> to ask me take the arch/arm/mach-mxs changes in this series then.

Yes, I'm quite aware this stuff might take a bit to get into mainline shape. I 
grouped this and MXS SPI together, maybe the MXS SPI stuff is a better 
representation of what I had in mind (about letting non-DT stuff for mxs slide 
in).

Best regards,
Marek Vasut
