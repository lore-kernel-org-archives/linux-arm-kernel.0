From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 9 Feb 2011 20:39:07 +0100
Subject: [PATCH] ARM: imx/eukrea_mbimx27: fix compile warnings about
	unused variables
In-Reply-To: <4D529D3E.5090405@ru.mvista.com>
References: <1297196241-26564-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4D529D3E.5090405@ru.mvista.com>
Message-ID: <20110209193907.GS27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09, 2011 at 04:57:18PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 08-02-2011 23:17, Uwe Kleine-K?nig wrote:
> 
> >Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
> [...]
> 
> >diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> >index 275c858..9ac5348 100644
> >--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> >+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> [...]
> >@@ -268,7 +268,8 @@ static struct ads7846_platform_data ads7846_config __initdata = {
> >  	.keep_vref_on		= 1,
> >  };
> >
> >-static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
> >+static struct spi_board_info __maybe_unused
> >+eukrea_mbimx27_spi_board_info[] __initdata = {
> 
>    I think the second line should be somewhat indented.
I like it as it is.  There are no rules for that, no?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
