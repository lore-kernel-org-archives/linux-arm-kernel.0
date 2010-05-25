From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 May 2010 11:04:31 +0200
Subject: [PATCH 05/16] arm/mx2/pca100: add #ifdef to fix compiler warning
In-Reply-To: <20100525000656.GA11887@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
	<1274730951-29106-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100525000656.GA11887@pengutronix.de>
Message-ID: <20100525090431.GA16160@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Tue, May 25, 2010 at 02:06:56AM +0200, Wolfram Sang wrote:
> On Mon, May 24, 2010 at 09:55:40PM +0200, Uwe Kleine-K?nig wrote:
> > This fixes:
> > 
> > 	arch/arm/mach-mx2/mach-pca100.c:261: warning: 'otg_pdata' defined but not used
> > 	arch/arm/mach-mx2/mach-pca100.c:273: warning: 'usbh2_pdata' defined but not used
> > 
> > for build having USB_ULPI disabled.
> 
> See:
> 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/80438/
ah, OK, your patch looks more complete.  I dropped my patch and took
your's instead.  While at it I took "[PATCH] pcm037: fix build warning",
too.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
