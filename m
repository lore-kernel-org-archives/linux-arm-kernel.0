From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:53 +0100
Subject: [PATCH v2 3/8] arm64: dts: marvell: fix typos in comment describing
 the NAND controller
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-4-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index ecbc76d26dff..a0b2cec2823f 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -317,7 +317,7 @@
 
 			cpm_nand: nand at 720000 {
 				/*
-				 * Due to the limiation of the pin available
+				 * Due to the limitation of the pins available
 				 * this controller is only usable on the CPM
 				 * for A7K and on the CPS for A8K.
 				 */
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 6a07c786b788..0624ec2de496 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -318,7 +318,7 @@
 
 			cps_nand: nand at 720000 {
 				/*
-				 * Due to the limiation of the pin available
+				 * Due to the limitation of the pins available
 				 * this controller is only usable on the CPM
 				 * for A7K and on the CPS for A8K.
 				 */
-- 
2.14.3
