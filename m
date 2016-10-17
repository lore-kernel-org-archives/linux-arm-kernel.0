From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 17 Oct 2016 18:30:50 +0200
Subject: [PATCH 3/3] ARM: dts: da850: add the syscfg and ddrctl nodes
In-Reply-To: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1476721850-454-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the nodes for the System Configuration and DDR2/mDDR memory
controller drivers to da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 6440002..6d56ef2 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -407,6 +407,16 @@
 			interrupts = <52>;
 			status = "disabled";
 		};
+
+		ddrctl: da850-ddrctl {
+			compatible = "ti,da850-ddrctl";
+			status = "disabled";
+		};
+
+		syscfg: da850-syscfg {
+			compatible = "ti,da850-syscfg";
+			status = "disabled";
+		};
 	};
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
-- 
2.9.3
