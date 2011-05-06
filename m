From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 6 May 2011 10:39:59 +0200
Subject: [PATCH v2 7/7] ARM: mxc: remove esdhc.h and use the public one
In-Reply-To: <1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110506083959.GS11574@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Thu, May 05, 2011 at 09:22:58PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
>  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
what about removing arch/arm/plat-mxc/include/mach/esdhc.h in this
patch as advertised in the subject?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
