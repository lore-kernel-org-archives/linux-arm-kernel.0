From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Jun 2015 15:30:59 -0700
Subject: [GIT PULL 0/5] ARM: SoC changes for v4.2
Message-ID: <1435271464-11455-1-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

As is usual of late, most of the changes are in DT contents for
various platforms, including support for new SoCs and new boards.  The
rest is spread out a bit, with more descriptions in each pull request.

No major conflicts this time, the couple simple ones that show up are
covered in each pull request.

Please merge,

Kevin (on behalf of arm-soc team: Olof, Arnd, myself)


Dirstat 
$ git diff --dirstat=0.2 v4.1..for-next
   0.8% Documentation/devicetree/bindings/arm/
   0.2% Documentation/devicetree/bindings/clock/
   0.7% Documentation/devicetree/bindings/memory-controllers/
   0.5% Documentation/devicetree/bindings/
  59.1% arch/arm/boot/dts/
   0.8% arch/arm/configs/
   0.5% arch/arm/mach-at91/include/mach/
   0.3% arch/arm/mach-at91/
   0.8% arch/arm/mach-bcm/
   0.3% arch/arm/mach-exynos/
   2.3% arch/arm/mach-imx/
   0.3% arch/arm/mach-omap1/include/mach/
   0.3% arch/arm/mach-omap1/
   3.5% arch/arm/mach-omap2/
   1.5% arch/arm/mach-pxa/
   0.6% arch/arm/mach-socfpga/
   0.2% arch/arm/mach-uniphier/
   0.2% arch/arm/mach-ux500/
   0.3% arch/arm/mach-zx/
   1.6% arch/arm/
   0.7% arch/arm64/boot/dts/arm/
   0.2% arch/arm64/boot/dts/hisilicon/
   0.2% arch/arm64/boot/dts/qcom/
   0.3% arch/sparc/kernel/
   0.4% arch/x86/kernel/cpu/
   0.2% arch/x86/
   0.4% arch/
   2.3% drivers/bus/
   4.0% drivers/clk/imx/
   1.4% drivers/clk/zte/
   0.8% drivers/clocksource/
   0.4% drivers/dma/
   1.6% drivers/firmware/
   0.2% drivers/leds/
   2.4% drivers/memory/tegra/
   0.3% drivers/net/ethernet/emulex/benet/
   0.4% drivers/net/ethernet/
   0.5% drivers/soc/qcom/
   0.3% drivers/soc/sunxi/
   0.3% drivers/staging/rtl8712/
   0.2% drivers/tty/
   0.2% drivers/usb/
   1.9% drivers/
   1.2% include/dt-bindings/clock/
   0.2% include/linux/mfd/syscon/
   0.2% include/linux/
   0.3% include/soc/
   0.3% net/
   0.2% sound/pci/hda/

Top 20 contributors by patch count (no merges)
$ git log --format=%an --no-merges v4.1..for-next  | sort | uniq -c  |sort -nr | head -n 20
     50 Krzysztof Kozlowski
     46 Maxime Ripard
     38 Geert Uytterhoeven
     30 Linus Walleij
     28 Shawn Guo
     27 Antoine Tenart
     25 Alexandre Belloni
     23 Chen-Yu Tsai
     19 Hans de Goede
     18 Lee Jones
     17 Arnd Bergmann
     15 Tony Lindgren
     15 Dinh Nguyen
     13 Stefan Agner
     13 Fabio Estevam
     12 Robert Jarzmik
     12 Ga?l PORTAY
     12 Florian Fainelli
     11 Thierry Reding
     10 Heiko Stuebner
