From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 20 Jul 2016 14:53:51 -0700
Subject: [PATCH v2 2/2] arm64: dts: Updated NAND DT properties for NS2 SVK
In-Reply-To: <1469051631-7896-1-git-send-email-ray.jui@broadcom.com>
References: <1469051631-7896-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1469051631-7896-3-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds NAND DT properties for NS2 SVK to configure the bus
width width and OOB sector size

Signed-off-by: Prafulla Kota <prafulla.kota@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 54ca40c..5ef0407 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -128,6 +128,8 @@
 		nand-ecc-mode = "hw";
 		nand-ecc-strength = <8>;
 		nand-ecc-step-size = <512>;
+		nand-bus-width = <16>;
+		brcm,nand-oob-sector-size = <16>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
-- 
2.1.4
