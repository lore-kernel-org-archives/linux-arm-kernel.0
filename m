From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 1 Mar 2012 15:00:36 +0800
Subject: [PATCH] Add devicetree support for i.MX27 SoCs
In-Reply-To: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120301070034.GA2268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 09:20:51AM +0100, Sascha Hauer wrote:
> Hi all,
> 
> I created the following mainly out of curiosity to find out what's
> missing to support a new i.MX SoC in the devicetree. It turned out
> it's not much thanks to the driver bindings which already exist for
> the bigger i.MXes. So here it is.
> 
> Sascha
> 
> Sascha Hauer (3):
>       ARM i.MX27: Add devicetree support
>       ARM i.MX: Add phytec phycore-i.MX27 (aka pcm038) devicetree support
>       devicetree-bindings: Add documentation for i.MX generic boards

For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> 
>  Documentation/devicetree/bindings/arm/fsl.txt |   22 +++
>  arch/arm/boot/dts/imx27-phytec-phycore.dts    |   76 +++++++++
>  arch/arm/boot/dts/imx27.dtsi                  |  217 +++++++++++++++++++++++++
>  arch/arm/mach-imx/Kconfig                     |    8 +
>  arch/arm/mach-imx/Makefile                    |    1 +
>  arch/arm/mach-imx/clock-imx27.c               |   18 ++
>  arch/arm/mach-imx/imx27-dt.c                  |   89 ++++++++++
>  arch/arm/plat-mxc/include/mach/common.h       |    1 +
>  8 files changed, 432 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx27-phytec-phycore.dts
>  create mode 100644 arch/arm/boot/dts/imx27.dtsi
>  create mode 100644 arch/arm/mach-imx/imx27-dt.c
