From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Aug 2010 16:21:51 +0200
Subject: [PATCH 14/19] usb gadget: don't save bind callback in struct
	usb_configuration
In-Reply-To: <1281017333-5563-14-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-14-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100805142151.GA4684@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg, Micha?,

On Thu, Aug 05, 2010 at 04:08:48PM +0200, Uwe Kleine-K?nig wrote:
> The bind function is only called at init time so there is no need to
> save a pointer to it in the driver struct.
> 
> This fixes many section mismatches reported by modpost.
Argh, this is the old commit log.  Please take the patch I sent earlier
to lkml and linux-usb

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
