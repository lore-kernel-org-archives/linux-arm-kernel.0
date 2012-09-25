From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Sep 2012 23:52:19 -0300
Subject: [PATCH 1/2] ARM: dts: imx23-olinuxino: Remove unneeded "default-on"
Message-ID: <1348541540-15641-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The initial state of the gpio led can be set directly in "gpios" node.

Hence, linux,default-trigger can be removed.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 384d8b6..35489a1 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -94,8 +94,7 @@
 
 		user {
 			label = "green";
-			gpios = <&gpio2 1 0>;
-			linux,default-trigger = "default-on";
+			gpios = <&gpio2 1 1>;
 		};
 	};
 };
-- 
1.7.9.5
