From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 25 May 2010 02:06:56 +0200
Subject: [PATCH 05/16] arm/mx2/pca100: add #ifdef to fix compiler warning
In-Reply-To: <1274730951-29106-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
	<1274730951-29106-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100525000656.GA11887@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 09:55:40PM +0200, Uwe Kleine-K?nig wrote:
> This fixes:
> 
> 	arch/arm/mach-mx2/mach-pca100.c:261: warning: 'otg_pdata' defined but not used
> 	arch/arm/mach-mx2/mach-pca100.c:273: warning: 'usbh2_pdata' defined but not used
> 
> for build having USB_ULPI disabled.

See:

http://article.gmane.org/gmane.linux.ports.arm.kernel/80438/

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100525/cb9af6da/attachment.sig>
