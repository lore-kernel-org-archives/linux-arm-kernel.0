From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 31 Jul 2013 16:37:51 +0200
Subject: [PATCH 1/10] ARM: dts: mxs: move 'compatible' property to beginning
 of node and do some whitespace cleanups
Message-ID: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 47fc5ef..0360acc 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -731,9 +731,9 @@
 			};
 
 			dcp at 80028000 {
+				compatible = "fsl-dcp";
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
-				compatible = "fsl-dcp";
 			};
 
 			pxp at 8002a000 {
@@ -815,7 +815,7 @@
 				reg = <0x8003c800 0x100>;
 				status = "disabled";
 			};
-                };
+		};
 
 		apbx at 80040000 {
 			compatible = "simple-bus";
@@ -1045,6 +1045,5 @@
 			reg = <0x800f8000 0x8000>;
 			status = "disabled";
 		};
-
 	};
 };
-- 
1.7.2.5
