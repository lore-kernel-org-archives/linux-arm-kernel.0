From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Feb 2011 09:45:33 +0100
Subject: [PATCH RESEND 3/4] ARM: imx53_loco: add i2c device support
In-Reply-To: <1298003777-7687-3-git-send-email-richard.zhao@freescale.com>
References: <1298003777-7687-1-git-send-email-richard.zhao@freescale.com>
	<1298003777-7687-3-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110218084533.GV22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 12:36:16PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 10b6008..abea297 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -146,6 +146,7 @@ config MACH_MX53_LOCO
>  	bool "Support MX53 LOCO platforms"
>  	select SOC_IMX53
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_IMX_I2C
please keep these sorted alphabetically

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
