From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Feb 2011 20:48:52 +0100
Subject: [PATCH 2/2] ARM: mach-mx5: Add watchdog support for MX53 based
	boards
In-Reply-To: <1297969066-14810-2-git-send-email-fabio.estevam@freescale.com>
References: <1297969066-14810-1-git-send-email-fabio.estevam@freescale.com>
	<1297969066-14810-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110217194851.GQ22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

just a small nitpick below, 

On Thu, Feb 17, 2011 at 04:57:46PM -0200, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig           |    3 +++
>  arch/arm/mach-mx5/board-mx53_evk.c  |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |    1 +
>  arch/arm/mach-mx5/board-mx53_smd.c  |    1 +
>  4 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 10b6008..8441462 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -128,6 +128,7 @@ config MACH_MX53_EVK
>  	select SOC_IMX53
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_IMX_I2C
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
IMX2 sorts before IMX_

Other than that ack for both patches.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
