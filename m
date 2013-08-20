From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Aug 2013 16:52:46 +0800
Subject: [PATCH v2] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
References: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130820085244.GD29114@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   7 +-
>  arch/arm/mach-imx/mm-imx25.c                       |  17 ---
>  arch/arm/mach-imx/mm-imx5.c                        |  14 --
>  drivers/dma/imx-sdma.c                             | 161 +++++++++++++++++----
>  4 files changed, 137 insertions(+), 62 deletions(-)
