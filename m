From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:28:21 +0200
Subject: [GIT PULL 0/8] ARM: SoC changes for v4.9
Message-ID: <3637015.LRn5VyhPVM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are 749 patches for ARM SoCs for this merge window, a bit less than
average this time. We support 29 new machines but all five SoCs we add
are in a family that is already supported.

Out of 165 developers contributing at least one patch, the most active
by number of patches are:

     46 Javier Martinez Canillas
     42 Sergei Shtylyov
     29 Linus Walleij
     25 Hans de Goede
     22 Krzysztof Kozlowski
     19 Vladimir Zapolskiy
     17 Patrice Chotard
     16 Grzegorz Jaszczyk
     14 Philipp Zabel
     14 Jon Mason
     14 Jisheng Zhang
     13 Vladimir Barinov

While according to Signed-off-by lines we get:

     87 Simon Horman
     86 Shawn Guo
     71 Tony Lindgren
     60 Maxime Ripard
     46 Javier Martinez Canillas
     45 Kevin Hilman
     44 Andy Gross
     42 Sergei Shtylyov
     40 Gregory CLEMENT
     35 Heiko Stuebner
     34 Krzysztof Kozlowski

The dirstat shows that once more the ARM32 dts changes dominate the
overall changes, surprisingly clearly this time showing how much
more work went into 32-bit platforms compared to 64-bit platforms:

   2.1% Documentation/devicetree/bindings/
  52.3% arch/arm/boot/dts/
   2.9% arch/arm/mach-clps711x/
   3.0% arch/arm/mach-imx/
   4.2% arch/arm/mach-omap2/
   9.9% arch/arm/mach-realview/
   4.2% arch/arm/
   2.2% arch/arm64/boot/dts/rockchip/
   9.2% arch/arm64/boot/dts/
   2.9% drivers/perf/
   5.5% drivers/
 742 files changed, 29317 insertions(+), 16385 deletions(-)

Ignoring dts and driver churn, we can see a nice cleanup, removing
almost 9000 lines of old platform code:

  12.2% arch/arm/mach-clps711x/
  12.7% arch/arm/mach-imx/
   1.4% arch/arm/mach-integrator/
  17.6% arch/arm/mach-omap2/
   1.4% arch/arm/mach-pxa/
  41.6% arch/arm/mach-realview/
   2.3% arch/arm/mach-uniphier/
   1.1% arch/arm/plat-orion/
   1.2% arch/arm/plat-pxa/include/plat/
   3.1% arch/arm/plat-pxa/
   4.6% arch/arm/
 172 files changed, 698 insertions(+), 9468 deletions(-)

	Arnd
