From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Jun 2013 14:14:31 +0800
Subject: [PATCH 0/9] Update imx6qdl dts/dtsi to support WM8962
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <20130614061429.GA20513@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 07:50:55PM +0800, Nicolin Chen wrote:
> Nicolin Chen (9):
>   ARM: clk-imx6qdl: Add clko1 configuration for imx6qdl-sabresd
>   ARM: dts: imx6qdl-sabresd: add clko1 iomux configuration
>   ARM: dtsi: imx6q/imx6dl: Add a pinctrl for I2C1
>   ARM: dtsi: imx6dl: Add a pinctrl for AUDMUX
>   ARM: dtsi: imx6qdl-sabresd: add a fixed regulator for WM8962
>   ARM: dtsi: imx6qdl-sabresd: Add WM8962 CODEC support
>   ARM: dtsi: imx6qdl-sabresd: Enable SSI2 and AUDMUX
>   ARM: dtsi: imx6qdl-sabresd: Enable WM8962 audio support
>   ARM: imx_v6_v7_defconfig: Enable imx-wm8962 by default

All applied.  I made some small fix-ups and have a few comments, but
nothing so important.  Please see my replies to individual patches.

Shawn
