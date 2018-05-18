From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 18 May 2018 08:00:56 +0530
Subject: [PATCH 5/5] MAINTAINERS: Add Actions Semi S900 pinctrl entries
In-Reply-To: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
References: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180518023056.7869-6-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add S900 pinctrl entries under ARCH_ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 640dabc4c311..9e1a17c9b4a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1125,10 +1125,12 @@ F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 
-- 
2.14.1
