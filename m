From: mporter@linaro.org (Matt Porter)
Date: Tue, 20 May 2014 16:28:06 -0400
Subject: [PATCH RESEND v2 4/4] ARM: dts: bcm590xx: add support for GPLDO and
 VBUS regulators
In-Reply-To: <1400617686-9701-1-git-send-email-mporter@linaro.org>
References: <1400617686-9701-1-git-send-email-mporter@linaro.org>
Message-ID: <1400617686-9701-5-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds additional nodes to support GPLDO1-6 and VBUS regulators which
are now supported in the bcm590xx regulator driver.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 arch/arm/boot/dts/bcm59056.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/bcm59056.dtsi b/arch/arm/boot/dts/bcm59056.dtsi
index dfadaaa..066adfb 100644
--- a/arch/arm/boot/dts/bcm59056.dtsi
+++ b/arch/arm/boot/dts/bcm59056.dtsi
@@ -70,5 +70,26 @@
 
 		vsr_reg: vsr {
 		};
+
+		gpldo1_reg: gpldo1 {
+		};
+
+		gpldo2_reg: gpldo2 {
+		};
+
+		gpldo3_reg: gpldo3 {
+		};
+
+		gpldo4_reg: gpldo4 {
+		};
+
+		gpldo5_reg: gpldo5 {
+		};
+
+		gpldo6_reg: gpldo6 {
+		};
+
+		vbus_reg: vbus {
+		};
 	};
 };
-- 
1.8.4
