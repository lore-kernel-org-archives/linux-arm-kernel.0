From: marex@denx.de (Marek Vasut)
Date: Wed, 9 Jan 2013 10:08:49 +0100
Subject: [PATCH] mtd: mxc_nand: Make use of supplied pinctrl data
In-Reply-To: <20130109064107.GB12525@S2100-06.ap.freescale.net>
References: <1357568885-15507-1-git-send-email-marex@denx.de>
 <201301082122.46815.marex@denx.de>
 <20130109064107.GB12525@S2100-06.ap.freescale.net>
Message-ID: <201301091008.49832.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Jan 08, 2013 at 09:22:46PM +0100, Marek Vasut wrote:
> > Dear Jean-Christophe PLAGNIOL-VILLARD,
> > 
> > > On 15:28 Mon 07 Jan     , Marek Vasut wrote:
> > > > The MXC NAND driver doesn't consider the pinctrl data supplied via
> > > > DT, which will result in NAND pins not being properly configured.
> > > > 
> > > > Make the driver use pinctrl, but to prevent breakage on various
> > > > boards, do not fail if the pinctrl data are not available, only
> > > > print a warning message.
> > > 
> > > nack
> > > 
> > > we will at bus level
> > 
> > Can you please elaborate? I don't understand what you're complaining
> > about at all, sorry.
> 
> He is talking about patch [1] which is likely to hit mainline for 3.9.
> 
> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.kernel/1409263

Oh, this is good, thanks for explaining Shawn!

Well, this patch can be applied as a fallback if it doesn't hit 3.9 , either way 
works for me.

Best regards,
Marek Vasut
