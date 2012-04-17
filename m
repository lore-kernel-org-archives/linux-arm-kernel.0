From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 22:10:31 +0200
Subject: [PATCH] i.MX28: Shut down the LCD controller to avoid bootrom
 sampling bug
In-Reply-To: <20120417174824.GD22406@pengutronix.de>
References: <1334675261-31570-1-git-send-email-marex@denx.de>
 <20120417174824.GD22406@pengutronix.de>
Message-ID: <201204172210.31232.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> On Tue, Apr 17, 2012 at 05:07:41PM +0200, Marek Vasut wrote:
> > From: Marek Vasut <marek.vasut@gmail.com>
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Chen Peter-B29397 <B29397@freescale.com>
> > Cc: Detlev Zundel <dzu@denx.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Li Frank-B20596 <B20596@freescale.com>
> > Cc: Lin Tony-B19295 <B19295@freescale.com>
> > Cc: Linux USB <linux-usb@vger.kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: Subodh Nijsure <snijsure@grid-net.com>
> > Cc: Tony Lin <tony.lin@freescale.com>
> > Cc: Wolfgang Denk <wd@denx.de>
> 
> Quite a CC list, but you forgot the main ones:

Do you have a trimmed-down version of the list of mxs-related people possibly?

> 
> FRAMEBUFFER LAYER
> M:      Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> L:      linux-fbdev at vger.kernel.org
> 
> Patch itself looks good

Who's applying this? The fbdev people or imx tree?

> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Best regards,
Marek Vasut
