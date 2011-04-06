From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Apr 2011 20:37:31 +0200
Subject: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
In-Reply-To: <20110406173151.GA7592@nataf.siach.name>
References: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110406173151.GA7592@nataf.siach.name>
Message-ID: <20110406183731.GH13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 08:31:51PM +0300, Baruch Siach wrote:
> Hi Uwe,
> 
> On Wed, Apr 06, 2011 at 04:29:04PM +0200, Uwe Kleine-K?nig wrote:
> > All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
> > so HAVE_FB_IMX can go away and there is no need anymore to explicitly
> > depend on ARCH_MX1 or ARCH_MX2.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> 
> Sascha has already sent a patch for this. See 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/109067.
yeah, this looks more complete. Thanks for pointing that out.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
