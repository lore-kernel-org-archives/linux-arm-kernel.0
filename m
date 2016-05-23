From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Mon, 23 May 2016 12:20:50 -0400
Subject: [PATCH 3/4] ARM: dts: nsp: Add rng device tree entry
In-Reply-To: <1464020451-16520-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1464020451-16520-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1464020451-16520-4-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the random number generator to the Northstar Plus
SoC device tree.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index def9e78..1ed829e 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -206,6 +206,11 @@
 			brcm,nand-has-wp;
 		};
 
+		rng: rng at 33000 {
+			compatible = "brcm,bcm-nsp-rng";
+			reg = <0x33000 0x14>;
+		};
+
 		ccbtimer0: timer at 34000 {
 			compatible = "arm,sp804";
 			reg = <0x34000 0x1000>;
-- 
2.1.0
