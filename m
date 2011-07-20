From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Jul 2011 21:24:19 +0800
Subject: [PATCH] arm/mxc: add the missing UART_PADDR for i.mx53
In-Reply-To: <20110720130830.GD2377@pengutronix.de>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<1311167599-21790-1-git-send-email-shawn.guo@linaro.org>
	<20110720130830.GD2377@pengutronix.de>
Message-ID: <20110720132418.GB6999@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 03:08:30PM +0200, Wolfram Sang wrote:
> On Wed, Jul 20, 2011 at 09:13:19PM +0800, Shawn Guo wrote:
> > The UART_PADDR definition for i.mx53 and i.mx50 is missing in
> > debug-macro.S.  It causes the build of i.mx53/50 fail.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Reported-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > ---
> > Troy,
> > 
> > Since I'm keen to get the build failure fixed, I just repost
> > the patch you sent with Sascha's comment fixed.  Hope you do
> > not mind.
> 
> Then you should at least add his Signed-off. And maybe also mark him as
> the author of the patch?
> 
I did exactly what you suggested here on a mx53 fec patch, but I was
told by Troy to change his s-o-b to reported-by.  So let's see what
he would say about this one.

-- 
Regards,
Shawn
