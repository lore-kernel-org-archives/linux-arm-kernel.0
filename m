From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 18 Aug 2014 16:58:37 +0200
Subject: [PATCH v2 9/9] arm: dts: mt6589: Change compatible string for GIC
In-Reply-To: <1408373917-10002-1-git-send-email-matthias.bgg@gmail.com>
References: <1408373917-10002-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1408373917-10002-10-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatible string of the GIC to the
new "arm,cortex-a7-gic" which does reflect the actual hardware.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt6589.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index fb922a6..2534ba5 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -91,7 +91,7 @@
 		};
 
 		gic: interrupt-controller at 10211000 {
-			compatible = "arm,cortex-a15-gic";
+			compatible = "arm,cortex-a7-gic";
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			reg = <0x10211000 0x1000>,
-- 
1.7.9.5
