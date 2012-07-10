From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jul 2012 10:08:11 +0300
Subject: [PATCH 5/6] ARM: apx4devkit: remove AUART3
In-Reply-To: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <1341904092-13777-6-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AUART3 is not available anymore. Pins are used as GPIOs.

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
 arch/arm/boot/dts/apx4devkit.dts |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
index 9cf5ae6..b30e9d7 100644
--- a/arch/arm/boot/dts/apx4devkit.dts
+++ b/arch/arm/boot/dts/apx4devkit.dts
@@ -149,12 +149,6 @@
 				pinctrl-0 = <&auart2_2pins_a>;
 				status = "okay";
 			};
-
-			auart3: serial at 80070000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&auart3_2pins_a>;
-				status = "okay";
-			};
 		};
 	};
 
-- 
1.7.9.5
