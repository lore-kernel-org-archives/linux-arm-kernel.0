From: hramrach@gmail.com (Michal Suchanek)
Date: 20 Aug 2015 14:19:47 -0000
Subject: [PATCH 6/9] ARM: dts: sunxi: add spi aliases on cubieboards
In-Reply-To: <cover.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
Message-ID: <b2d2cea6f06d54fe1c160fcdcaab7c53585d52d9.1440080122.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aliases give nicer device node names.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts  | 1 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 9afb4e0..ba02f3b 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -54,6 +54,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		spi0 = &spi0;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 9861304..4c952a2 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -56,6 +56,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		spi0 = &spi0;
 	};
 
 	chosen {
-- 
2.1.4
