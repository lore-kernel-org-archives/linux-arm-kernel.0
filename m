From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:24:00 +0100
Subject: [PATCH v2 17/19] ARM: dts: armada-370-xp: Remove address from dsa
 unit name
In-Reply-To: <20161113212402.3060-1-gregory.clement@free-electrons.com>
References: <20161113212402.3060-1-gregory.clement@free-electrons.com>
Message-ID: <20161113212402.3060-18-gregory.clement@free-electrons.com>
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
index 66974ab4d334..3247e456a219 100644
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
index c5ca7525389b..2eb0cc58cf50 100644
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
2.10.2
