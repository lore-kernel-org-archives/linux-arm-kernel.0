From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Jul 2011 09:38:44 +0200
Subject: [PATCH v2 4/7] spi/imx: merge type SPI_IMX_VER_0_7 into
	SPI_IMX_VER_0_4
In-Reply-To: <1310231801-18761-5-git-send-email-shawn.guo@linaro.org>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110711073844.GC13840@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 01:16:38AM +0800, Shawn Guo wrote:
> The only difference between SPI_IMX_VER_0_7 and SPI_IMX_VER_0_4 is
> .config function.  The patch uses cpu_is_mx35 (to be removed) as the
> temporary solution to consolidate functions spi_imx0_4_config and
> spi_imx0_7_config into mx31_config.  As a result, type SPI_IMX_VER_0_7
> can be merged into SPI_IMX_VER_0_4.
> 
> It also renames function spi_imx0_4_reset to mx31_reset to keep
> consistency with other function naming.
> 
> A couple of redundant macros, MX3_CSPISTAT and MX3_CSPISTAT_RR,
> together with the useless type SPI_IMX_VER_0_5 also get cleaned up.
s/useless/unused/?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
