From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Nov 2010 10:31:58 +0100
Subject: Pull Request i.MX
In-Reply-To: <20101115082910.GJ6017@pengutronix.de>
References: <20101115082910.GJ6017@pengutronix.de>
Message-ID: <20101123093158.GD8950@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 09:29:10AM +0100, Sascha Hauer wrote:
> Hi Russell,
> 
> Please pull the following patches for -rc.

Ping. Anything wrong with this or have you just overlooked it?

Sascha

> 
> Sascha
> 
> The following changes since commit 151f52f09c5728ecfdd0c289da1a4b30bb416f2c:
> 
>   ipw2x00: remove the right /proc/net entry (2010-11-05 18:57:04 -0700)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk
> 
> Alberto Panizzo (1):
>       mach-pcm037_eet: Fix section mismatch for eet_init_devices()
> 
> Baruch Siach (1):
>       mx25: fix spi device registration typo
> 
> Sascha Hauer (5):
>       ARM mx3fb: check for DMA engine type
>       ARM i.MX: sdma is merged, so remove #ifdef SDMA_IS_MERGED
>       ARM i.MX pcm037 eet: compile fixes
>       ARM i.MX spi: fix compilation for i.MX21
>       ARM i.MX27 eukrea: Fix compilation
> 
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    6 ------
>  arch/arm/mach-mx25/devices-imx25.h           |    4 ++--
>  arch/arm/mach-mx3/mach-pcm037_eet.c          |    5 ++---
>  arch/arm/plat-mxc/devices/platform-imx-dma.c |    8 --------
>  arch/arm/plat-mxc/devices/platform-spi_imx.c |    1 +
>  drivers/video/mx3fb.c                        |    4 ++++
>  6 files changed, 9 insertions(+), 19 deletions(-)
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
