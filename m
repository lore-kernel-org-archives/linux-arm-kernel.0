From: b18965@freescale.com (Alison Wang)
Date: Mon, 6 Jul 2015 10:38:12 +0800
Subject: [PATCH] arm: dts: ls1021a: Add LTC2945 node for LS1021A TWR board
Message-ID: <1436150292-15046-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jia Hongtao <hongtao.jia@freescale.com>

This patch adds LTC2945 node for LS1021A TWR board.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a0d9ad6..938b16a 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -160,6 +160,13 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+	monitor: ltc2945 at 67 {
+		reg = <0x67>;
+	};
+};
+
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-- 
2.1.0.27.g96db324
