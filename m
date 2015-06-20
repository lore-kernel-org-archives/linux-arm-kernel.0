From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Jun 2015 10:17:30 +0200
Subject: [PATCH v3 5/6] ARM: dts: pxa: fix power i2c definition
In-Reply-To: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
References: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1434788251-11839-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the correct address and size to the device-tree description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 1402e23..fc79df9 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -59,6 +59,8 @@
 			reg = <0x40f00180 0x24>;
 			interrupts = <6>;
 			clocks = <&clks CLK_PWRI2C>;
+			#address-cells = <0x1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.1.4
