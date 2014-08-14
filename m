From: zonque@gmail.com (Daniel Mack)
Date: Thu, 14 Aug 2014 11:46:13 +0200
Subject: [PATCH 2/2] ARM: pxa: dts: fix ohci controller compatible string
In-Reply-To: <1408009573-24523-1-git-send-email-zonque@gmail.com>
References: <1408009573-24523-1-git-send-email-zonque@gmail.com>
Message-ID: <1408009573-24523-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vendor prefix was renamed from "mrvl" to "marvell". Follow this
change in the dts file.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index f188f8c..6d52a72 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -121,7 +121,7 @@
 		};
 
 		usb0: ohci at 4c000000 {
-			compatible = "mrvl,pxa-ohci";
+			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
 			status = "disabled";
-- 
2.0.4
