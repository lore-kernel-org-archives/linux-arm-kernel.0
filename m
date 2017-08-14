From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Aug 2017 10:44:54 +0800
Subject: [PATCH] MAINTAINERS: update ARM/ZTE entry
Message-ID: <1502678694-8874-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update ARM/ZTE entry to include all those ZTE ZX platform drivers and
files that do not have a separate MAINTAINERS entry.

Since I have been contributing a lot for ZTE ZX SoCs support and
collecting platform patches for a few cycles, add myself as one
maintainer for the platform.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
Hi Arnd, Olof,

Can you please apply the patch directly to arm-soc if you are fine with
it.  Or if you would like a pull request for this, please let me know.

Shawn

 MAINTAINERS | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205d3977ac46..4d6eb5571593 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2057,17 +2057,38 @@ F:	arch/arm/mach-pxa/include/mach/z2.h
 ARM/ZTE ARCHITECTURE
 M:	Jun Nie <jun.nie@linaro.org>
 M:	Baoyou Xie <baoyou.xie@linaro.org>
+M:	Shawn Guo <shawnguo@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/boot/dts/zx2967*
 F:	arch/arm/mach-zx/
+F:	arch/arm64/boot/dts/zte/
 F:	drivers/clk/zte/
+F:	drivers/dma/zx_dma.c
+F:	drivers/gpio/gpio-zx.c
+F:	drivers/i2c/busses/i2c-zx2967.c
+F:	drivers/mmc/host/dw_mmc-zx.*
+F:	drivers/pinctrl/zte/
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
+F:	drivers/thermal/zx2967_thermal.c
+F:	drivers/watchdog/zx2967_wdt.c
 F:	Documentation/devicetree/bindings/arm/zte.txt
-F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/clock/zx2967*.txt
+F:	Documentation/devicetree/bindings/dma/zxdma.txt
+F:	Documentation/devicetree/bindings/gpio/zx296702-gpio.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
+F:	Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
+F:	Documentation/devicetree/bindings/pinctrl/pinctrl-zx.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
-F:	include/dt-bindings/soc/zx*.h
+F:	Documentation/devicetree/bindings/sound/zte,*.txt
+F:	Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
+F:	Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
+F:	include/dt-bindings/clock/zx2967*.h
+F:	include/dt-bindings/soc/zte,*.h
+F:	sound/soc/codecs/zx_aud96p22.c
+F:	sound/soc/zte/
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
-- 
1.9.1
