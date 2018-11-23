From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 12:22:17 +0100
Subject: [PATCH 3/3] ARM64: dts: marvell: armada-3720-espressobin: declare
 USB3 PHY
In-Reply-To: <20181123112217.4878-1-miquel.raynal@bootlin.com>
References: <20181123112217.4878-1-miquel.raynal@bootlin.com>
Message-ID: <20181123112217.4878-4-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB3 node is wired to the first PHY of the COMPHY IP.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index e947ef61d946..094994a9c68e 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -112,6 +112,7 @@
 /* J7 */
 &usb3 {
 	status = "okay";
+	phys = <&comphy0 0>;
 };
 
 /* J8 */
-- 
2.19.1
