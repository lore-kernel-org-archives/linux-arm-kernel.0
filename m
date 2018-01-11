From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 11 Jan 2018 14:59:02 +1300
Subject: [PATCH v2 2/3] ARM: dts: armada-xp: add label to sdram-controller node
In-Reply-To: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz>
References: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180111015903.11322-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the label "sdramc" to the sdram-controller nodes for the Armada-XP
and 98dx3236 SoCs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- New

 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index bdd4c7a45fbf..fe54e9d7cc90 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -127,7 +127,7 @@
 		};
 
 		internal-regs {
-			sdramc at 1400 {
+			sdramc: sdramc at 1400 {
 				compatible = "marvell,armada-xp-sdram-controller";
 				reg = <0x1400 0x500>;
 			};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index fa1e881266ac..3bb6e5e59fcc 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -73,7 +73,7 @@
 		};
 
 		internal-regs {
-			sdramc at 1400 {
+			sdramc: sdramc at 1400 {
 				compatible = "marvell,armada-xp-sdram-controller";
 				reg = <0x1400 0x500>;
 			};
-- 
2.15.1
