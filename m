From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Feb 2014 20:33:07 +0100
Subject: [PATCH] ARM: mach-imx: Kconfig: Remove
 IMX_HAVE_PLATFORM_IMX2_WDT from SOC_IMX53
In-Reply-To: <1392990753-9869-1-git-send-email-festevam@gmail.com>
References: <1392990753-9869-1-git-send-email-festevam@gmail.com>
Message-ID: <20140221193307.GO6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 10:52:33AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> SOC_IMX53 is a device-tree only platform, so we don't need 
> IMX_HAVE_PLATFORM_IMX2_WDT at all.
Maybe add to the changelog:

... because this symbol only provides some code to help register
imx2-wdt platform devices.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
