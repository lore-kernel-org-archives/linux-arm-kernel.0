From: jonmason@broadcom.com (Jon Mason)
Date: Thu,  5 May 2016 19:29:31 -0400
Subject: [PATCH 2/3] ARM: dts: NSP: modify second CPU address
In-Reply-To: <1462490972-13566-1-git-send-email-jonmason@broadcom.com>
References: <1462490972-13566-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1462490972-13566-2-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NSP B0 has a different address for the second core.  Since there should
not be any Ax versions in the field, it should be safe to universally
change this.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index a44bf29..1759e65 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -57,7 +57,7 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			enable-method = "brcm,bcm-nsp-smp";
-			secondary-boot-reg = <0xffff042c>;
+			secondary-boot-reg = <0xffff0fec>;
 			reg = <0x1>;
 		};
 	};
-- 
1.9.1
