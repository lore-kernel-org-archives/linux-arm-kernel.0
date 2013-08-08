From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 14:51:20 +0200
Subject: [PATCH 1/8] ARM: dts: mxs: whitespace cleanup
In-Reply-To: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375966287-6784-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 47fc5ef..e8e5d49 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
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
