From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Dec 2010 15:51:06 +0100
Subject: [PATCH v3 15/15] ARM: mxs: Add build configuration for mxs
In-Reply-To: <1291739523-25077-12-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-12-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101210145106.GM17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Shawn,

On Wed, Dec 08, 2010 at 12:32:03AM +0800, Shawn Guo wrote:
>  - Remove cpu.o from arch/arm/mach-mxs/Makefile
> [...]
>
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> new file mode 100644
> index 0000000..40b808c
> --- /dev/null
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -0,0 +1,10 @@
> +# Common support
> +obj-y := clock.o cpu.o devices.o gpio.o icoll.o iomux.o system.o timer.o
                    ^^^^^

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
