From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Mon,  9 Jul 2018 16:19:22 +0200
Subject: [PATCH v5 7/7] ARM: dts: rcar-gen2: Remove un-supported VIN properties
In-Reply-To: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1531145962-1540-8-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove from VIN interface description properties that are not listed as
supported in bindings documentation, as their value is fixed in the hardware.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm/boot/dts/r8a7790-lager.dts   | 2 --
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 --
 arch/arm/boot/dts/r8a7793-gose.dts    | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 092610e..250f698 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -888,8 +888,6 @@
 			bus-width = <24>;
 			hsync-active = <0>;
 			vsync-active = <0>;
-			pclk-sample = <1>;
-			data-active = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 8ab793d..1becb79 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -860,8 +860,6 @@
 			bus-width = <24>;
 			hsync-active = <0>;
 			vsync-active = <0>;
-			pclk-sample = <1>;
-			data-active = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index aa209f6..f57a7ae 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -768,8 +768,6 @@
 			bus-width = <24>;
 			hsync-active = <0>;
 			vsync-active = <0>;
-			pclk-sample = <1>;
-			data-active = <1>;
 		};
 	};
 };
-- 
2.7.4
