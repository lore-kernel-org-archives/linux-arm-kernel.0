From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:03:46 +0100
Subject: [GIT PULL 0/7] ARM: SoC changes for v4.11
Message-ID: <8729461.VkrRdW7LzJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This seems to be a rather quiet merge window for us, with no invasive
changes made, or major platforms added. These are the first seven pull
requests for the merge window, we have one 'late' branch that we may
send in a few days, and there are some pending bugfixes as well.

Some statistics:

We pulled 108 branches with a total of 700 non-merge changesets, almost
500 of those being devicetree changes. 

There were 175 individual contributors, the ones with the most patches are:
 
     27 Simon Horman <horms+renesas@verge.net.au>
     22 Bartosz Golaszewski <bgolaszewski@baylibre.com>
     21 Geert Uytterhoeven <geert+renesas@glider.be>
     19 Marek Szyprowski <m.szyprowski@samsung.com>
     18 Icenowy Zheng <icenowy@aosc.xyz>
     16 Russell King <rmk+kernel@armlinux.org.uk>
     15 Suman Anna <s-anna@ti.com>
     14 Linus Walleij <linus.walleij@linaro.org>
     14 Krzysztof Kozlowski <krzk@kernel.org>
     12 Dinh Nguyen <dinguyen@kernel.org>
     11 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
     11 Patrice Chotard <patrice.chotard@st.com>
     11 Jon Mason <jon.mason@broadcom.com>
     11 Fabio Estevam <fabio.estevam@nxp.com>
     11 Amelie Delaunay <amelie.delaunay@st.com>
     10 Tony Lindgren <tony@atomide.com>
     10 Olof Johansson <olof@lixom.net>
     10 Maxime Ripard <maxime.ripard@free-electrons.com>
     10 David Lechner <david@lechnology.com>
      9 Teresa Remmet <t.remmet@phytec.de>

git diff v4.10-rc8..for-next --dirstat=0.1
   0.1% Documentation/devicetree/bindings/arm/marvell/
   0.1% Documentation/devicetree/bindings/arm/
   0.2% Documentation/devicetree/bindings/gpu/
   0.1% Documentation/devicetree/bindings/net/
   0.5% Documentation/devicetree/bindings/reset/
   0.1% Documentation/devicetree/bindings/soc/
   0.2% Documentation/devicetree/bindings/
  64.3% arch/arm/boot/dts/
   0.8% arch/arm/configs/
   0.2% arch/arm/mach-davinci/
   0.1% arch/arm/mach-exynos/
   1.8% arch/arm/mach-imx/
   0.2% arch/arm/mach-mvebu/
   0.2% arch/arm/mach-omap1/
   1.1% arch/arm/mach-omap2/
   0.1% arch/arm/mach-s3c64xx/
   0.4% arch/arm/mach-shmobile/
   0.6% arch/arm/mach-ux500/
   1.6% arch/arm/
   0.8% arch/arm64/boot/dts/allwinner/
   1.3% arch/arm64/boot/dts/amlogic/
   0.4% arch/arm64/boot/dts/arm/
   0.8% arch/arm64/boot/dts/broadcom/
  10.0% arch/arm64/boot/dts/exynos/
   2.0% arch/arm64/boot/dts/freescale/
   0.4% arch/arm64/boot/dts/hisilicon/
   0.8% arch/arm64/boot/dts/marvell/
   0.3% arch/arm64/boot/dts/nvidia/
   0.9% arch/arm64/boot/dts/qcom/
   1.5% arch/arm64/boot/dts/renesas/
   0.4% arch/arm64/boot/dts/rockchip/
   0.1% arch/arm64/boot/dts/zte/
   0.1% arch/arm64/boot/dts/
   0.5% drivers/ata/
   0.1% drivers/clk/meson/
   0.1% drivers/firmware/
   0.4% drivers/memory/
   0.3% drivers/reset/hisilicon/
   0.5% drivers/reset/
   0.6% drivers/soc/rockchip/
   0.2% drivers/soc/samsung/
   0.9% drivers/soc/zte/
   0.1% drivers/soc/
   0.1% include/dt-bindings/clock/
   0.1% include/dt-bindings/mfd/
   0.1% include/dt-bindings/pinctrl/
   0.1% include/dt-bindings/
   0.4% include/linux/soc/samsung/
   0.3% include/linux/
