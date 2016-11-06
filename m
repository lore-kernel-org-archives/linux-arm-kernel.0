From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun,  6 Nov 2016 23:27:10 +0100
Subject: [PATCH 17/19] ARM: dts: armada-370-xp: Remove address from dsa unit
 name
In-Reply-To: <20161106222712.27366-1-gregory.clement@free-electrons.com>
References: <20161106222712.27366-1-gregory.clement@free-electrons.com>
Message-ID: <20161106222712.27366-18-gregory.clement@free-electrons.com>
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
index 8223e0aefac8..cff178004f59 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -172,7 +172,7 @@
 		};
 	};
 
-	dsa at 0 {
+	dsa {
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index fa1a84b20268..fd16af578fa8 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -301,7 +301,7 @@
 				      4500 1>;
 	};
 
-	dsa at 0 {
+	dsa {
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
-- 
2.10.1
