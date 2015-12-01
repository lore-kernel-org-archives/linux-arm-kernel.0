From: haibo.chen@freescale.com (Haibo Chen)
Date: Tue, 1 Dec 2015 16:22:30 +0800
Subject: [PATCH v4 4/4] ARM: dts: imx7d-sdb: add ADC support
In-Reply-To: <1448958150-25579-1-git-send-email-haibo.chen@freescale.com>
References: <1448958150-25579-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1448958150-25579-5-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADC support for imx7d-sdb board.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 432aaf5..b2c4536 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -97,6 +97,16 @@
 	};
 };
 
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&adc2 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
 &cpu0 {
 	arm-supply = <&sw1a_reg>;
 };
-- 
1.9.1
