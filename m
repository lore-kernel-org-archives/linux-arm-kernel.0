From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  1 Jul 2017 15:16:37 +0100
Subject: [PATCH 5/5] ARM64: dts: marvell: armada37xx: Enable USB2 on
 espressobin
In-Reply-To: <20170701141637.24719-1-marc.zyngier@arm.com>
References: <20170701141637.24719-1-marc.zyngier@arm.com>
Message-ID: <20170701141637.24719-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Espressobin SBC has a USB2 interface available on J8. Let's
enable it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index e3a136ed77b0..b1af3f988b29 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -81,6 +81,11 @@
 	status = "okay";
 };
 
+/* J8 */
+&usb2 {
+	status = "okay";
+};
+
 &mdio {
 	switch0: switch0 at 1 {
 		compatible = "marvell,mv88e6085";
-- 
2.11.0
