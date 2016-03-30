From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Mar 2016 19:47:59 +0800
Subject: [PATCH 0/4] Add support for Engicam IMX6UL module
In-Reply-To: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
Message-ID: <20160330114748.GF28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 11:20:48AM +0100, Michael Trimarchi wrote:
> Thi patch series add the support for Engicam IMXUL product
> 
> https://community.freescale.com/docs/DOC-328428
> 
> Based on Freescale? i.MX 6UltraLite processor, a high performance,
> ultra-efficient processor family featuring an advanced implementation
> of a single ARM? Cortex?-A7 core, which operates at speeds up to 528 MHz.
> 
> The new ENGICAM GEA M6UL module is suitable for cost effective HMI
> applications requiring high performance CPU.
> 
> Michael Trimarchi (4):
>   ARM: dts: imx6ul: Add flexcan1 and flexcan2 support
>   ARM: dts: imx6ul: Add LCDIF support
>   ARM: dts: imx6ul: Add GPMI nand controller support
>   ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support

There are quite some changes around imx6ul.dtsi getting into 4.6-rc1.
Can you please rebase onto 4.6-rc1 and resend?

Shawn

> 
>  arch/arm/boot/dts/Makefile             |   3 +-
>  arch/arm/boot/dts/imx6ul-geam-kit.dts  | 102 +++++++++
>  arch/arm/boot/dts/imx6ul-geam.dtsi     | 371 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6ul.dtsi          |  68 ++++++
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |  10 +
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |   6 +-
>  6 files changed, 557 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6ul-geam-kit.dts
>  create mode 100644 arch/arm/boot/dts/imx6ul-geam.dtsi
> 
> -- 
> 2.7.0
> 
> 
