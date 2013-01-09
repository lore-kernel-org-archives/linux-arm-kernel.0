From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 Jan 2013 14:41:10 +0800
Subject: [PATCH] mtd: mxc_nand: Make use of supplied pinctrl data
In-Reply-To: <201301082122.46815.marex@denx.de>
References: <1357568885-15507-1-git-send-email-marex@denx.de>
 <20130108195826.GD7360@game.jcrosoft.org>
 <201301082122.46815.marex@denx.de>
Message-ID: <20130109064107.GB12525@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 09:22:46PM +0100, Marek Vasut wrote:
> Dear Jean-Christophe PLAGNIOL-VILLARD,
> 
> > On 15:28 Mon 07 Jan     , Marek Vasut wrote:
> > > The MXC NAND driver doesn't consider the pinctrl data supplied via DT,
> > > which will result in NAND pins not being properly configured.
> > > 
> > > Make the driver use pinctrl, but to prevent breakage on various boards,
> > > do not fail if the pinctrl data are not available, only print a warning
> > > message.
> > 
> > nack
> > 
> > we will at bus level
> 
> Can you please elaborate? I don't understand what you're complaining about at 
> all, sorry.
> 
He is talking about patch [1] which is likely to hit mainline for 3.9.

Shawn

[1] http://thread.gmane.org/gmane.linux.kernel/1409263
