From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Jan 2016 16:08:20 +0100
Subject: [PATCH 2/2] ARM: mvebu: add reference to ETH connectors for A385-AP
In-Reply-To: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1453907300-28283-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds some comments to the Armada 385 AP Device Tree
description to indicate which Ethernet interface matches which
physical connector on the board.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db-ap.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index acd5b15..86fde0b 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -134,18 +134,21 @@
 				};
 			};
 
+			/* CON3 */
 			ethernet at 30000 {
 				status = "okay";
 				phy = <&phy2>;
 				phy-mode = "sgmii";
 			};
 
+			/* CON2 */
 			ethernet at 34000 {
 				status = "okay";
 				phy = <&phy1>;
 				phy-mode = "sgmii";
 			};
 
+			/* CON4 */
 			ethernet at 70000 {
 				pinctrl-names = "default";
 
-- 
2.6.4
