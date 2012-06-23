From: marex@denx.de (Marek Vasut)
Date: Sat, 23 Jun 2012 04:15:18 +0200
Subject: [PATCH] mtd/m25p80: add device tree probe support
In-Reply-To: <20110728214521.GA4674@ponder.secretlab.ca>
References: <1311601063-16581-1-git-send-email-shawn.guo@linaro.org>
 <4E31B713.1030901@free.fr> <20110728214521.GA4674@ponder.secretlab.ca>
Message-ID: <201206230415.18833.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Likely,

> On Thu, Jul 28, 2011 at 09:22:59PM +0200, manu wrote:
> > Dear Grant, Shawn,
> > I don't this patch is required as m25p** serial flashes are
> > supported already with generic OF/SPI and OF/MTD schemes.
> > I have successfully used it myself on an unmodified 2.6.36.3 vanilla
> > kernel on a xilinx/powerpc platform with a m25p32 part from STM.
> > You will find attached the corresponding working defconfig + dts
> > files (appart from partitions which I didn't managed to configure
> > properly...).
> > Best Regards,
> > 
> > Manuel
> 
> There is a heuristic which allows spi and i2c devices to get bound
> without a match table, which is why it works for you, but there is no
> guarantee that the heuristic will continue to exist in the long term.
> This is still probably the right thing to do.
> 
> g.

So is there any particular reason why this wasn't applied?

Best regards,
Marek Vasut
