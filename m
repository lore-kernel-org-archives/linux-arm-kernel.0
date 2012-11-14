From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 16:44:34 +0100
Subject: [PATCH 1/3] arm: mvebu: fix compatible string in armada-370-xp.dtsi
In-Reply-To: <1352907876-32482-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352907876-32482-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352907876-32482-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the Device Tree files for Armada 370 and XP SoCs and boards use
the "armada-370-xp" common compatible string, except
armada-370-xp.dtsi which was specifying "armada_370_xp".

Fix this inconsistency by making armada-370-xp.dtsi declare a
compatible string of "armada-370-xp" like everyone else.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 16cc82c..b113e0b 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -20,7 +20,7 @@
 
 / {
 	model = "Marvell Armada 370 and XP SoC";
-	compatible = "marvell,armada_370_xp";
+	compatible = "marvell,armada-370-xp";
 
 	cpus {
 		cpu at 0 {
-- 
1.7.9.5
