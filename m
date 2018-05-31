From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 31 May 2018 20:53:00 +0530
Subject: [PATCH] MAINTAINERS: Add Actions Semi S900 clk entries
Message-ID: <1527780180-15041-1-git-send-email-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add S900 clk entries under ARCH_ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48bfffe..964cd28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1143,12 +1143,14 @@ N:	owl
 F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
+F:	drivers/clk/actions/
 F:	drivers/clocksource/owl-*
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.7.4
