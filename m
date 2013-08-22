From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Aug 2013 09:13:29 +0200
Subject: [PATCH v2] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
References: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130822071329.GC31060@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Vinod,

Is this series ok for you to apply?

Thanks
 Sascha

On Tue, Aug 20, 2013 at 10:04:30AM +0200, Sascha Hauer wrote:
> Changes since v1:
> 
> - skip handling of SoCs which have a tapeout specific SDMA firmware,
>   namely i.MX31/35
> 
> ----------------------------------------------------------------
> Sascha Hauer (3):
>       dma: imx-sdma: Use struct for driver data
>       dma: imx-sdma: Add ROM script addresses to driver
>       ARM: i.MX: remove sdma script address arrays from platform data
> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   7 +-
>  arch/arm/mach-imx/mm-imx25.c                       |  17 ---
>  arch/arm/mach-imx/mm-imx5.c                        |  14 --
>  drivers/dma/imx-sdma.c                             | 161 +++++++++++++++++----
>  4 files changed, 137 insertions(+), 62 deletions(-)
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
