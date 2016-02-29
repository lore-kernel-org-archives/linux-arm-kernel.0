From: alexandre.torgue@gmail.com (Alexandre TORGUE)
Date: Mon, 29 Feb 2016 17:29:34 +0100
Subject: [PATCH 1/3] ARM: dts: stm32f429: Add system config bank node
In-Reply-To: <1456763376-21457-1-git-send-email-alexandre.torgue@gmail.com>
References: <1456763376-21457-1-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <1456763376-21457-2-git-send-email-alexandre.torgue@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 598362e..bb7a736 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -171,6 +171,11 @@
 			status = "disabled";
 		};
 
+		syscfg: system-config at 40013800 {
+			compatible = "syscon";
+			reg = <0x40013800 0x400>;
+		};
+
 		pin-controller {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.9.1
