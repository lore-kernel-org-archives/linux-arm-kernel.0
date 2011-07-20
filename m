From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 20 Jul 2011 15:08:30 +0200
Subject: [PATCH] arm/mxc: add the missing UART_PADDR for i.mx53
In-Reply-To: <1311167599-21790-1-git-send-email-shawn.guo@linaro.org>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<1311167599-21790-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110720130830.GD2377@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 09:13:19PM +0800, Shawn Guo wrote:
> The UART_PADDR definition for i.mx53 and i.mx50 is missing in
> debug-macro.S.  It causes the build of i.mx53/50 fail.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reported-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
> Troy,
> 
> Since I'm keen to get the build failure fixed, I just repost
> the patch you sent with Sascha's comment fixed.  Hope you do
> not mind.

Then you should at least add his Signed-off. And maybe also mark him as
the author of the patch?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/3ce61987/attachment.sig>
