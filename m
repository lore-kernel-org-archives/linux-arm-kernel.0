From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 15:18:31 +0100
Subject: [PATCH 12/12] ARM64: dts: marvell: armada-3720-espressobin: declare
 PCIe PHY
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
Message-ID: <20181123141831.8214-13-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe node is wired to the second PHY of the COMPHY IP.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 76a508da80b9..43e8e1edc467 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -49,6 +49,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_HIGH>;
+	phys = <&comphy1 0>;
 };
 
 /* J6 */
-- 
2.19.1
