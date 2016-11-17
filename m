From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:05:06 +0100
Subject: [PATCH v3 17/19] ARM: dts: armada-370-xp: Remove address from dsa
 unit name
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-18-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dsa node does not have a reg property, so remove the address from the
unit name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts           | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 4b0e576a2649..649dc108bc08 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -180,7 +180,7 @@
 		};
 	};
 
-	dsa at 0 {
+	dsa {
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 2cd02f62f224..f17c98d6cd0f 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -309,7 +309,7 @@
 				      4500 1>;
 	};
 
-	dsa at 0 {
+	dsa {
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
-- 
2.10.2
