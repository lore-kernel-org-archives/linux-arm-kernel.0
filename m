From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue,  9 Sep 2014 18:51:04 +0200
Subject: [PATCH v3 7/7] arm: dts: mt6589: Change compatible string for GIC
In-Reply-To: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
References: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1410281464-9587-8-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatible string of the GIC to the
new "arm,cortex-a7-gic" which does reflect the actual hardware.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt6589.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index 742c9bd..e3c7600 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -82,7 +82,7 @@
 		};
 
 		gic: interrupt-controller at 10211000 {
-			compatible = "arm,cortex-a15-gic";
+			compatible = "arm,cortex-a7-gic";
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			reg = <0x10211000 0x1000>,
-- 
1.9.1
