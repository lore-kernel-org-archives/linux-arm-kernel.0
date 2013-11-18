From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Nov 2013 09:25:12 +0800
Subject: [PATCH 0/8] imx6 dts cleanup series
In-Reply-To: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20131118012510.GL11014@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:02:06PM -0700, Troy Kisky wrote:
> This is a cleanup series. Only patch 8 adds new functionality,
> dualLite support for the sabrelite board.
> 
> patches 1-6 can be applied in any order
> patch 7 depends on patches 4,5
> patch 8 depends on patch 3
> 
> 
> Troy Kisky (8):
>   ARM: dts: imx: pinfunc: add MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT
>   ARM: dts: imx: imx6qdl.dtsi: add mipi_csi tag
>   ARM: dts: imx: imx6sl/qdl-pingrp: reorganize USDHCx pad groups

Except this one ...

>   ARM: dts: imx: imx6q.dtsi: use IRQ_TYPE_LEVEL_HIGH
>   ARM: dts: imx: imx6dl.dtsi: use IRQ_TYPE_LEVEL_HIGH
>   ARM: dts: imx: imx6sl.dtsi: use IRQ_TYPE_LEVEL_HIGH
>   ARM: dts: imx: imx6qdl.dtsi: use IRQ_TYPE_LEVEL_HIGH
>   ARM: dts: imx: sabrelite: add dualLite support

... and this one, applied all other 6 patches.

Shawn
