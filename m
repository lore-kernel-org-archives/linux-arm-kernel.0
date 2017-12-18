From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 18 Dec 2017 13:35:48 +0100
Subject: [PATCH v2] ARM: dts: sun8i: h3: nanopi-m1-plus: fix missing ethernet
 0 in aliases
Message-ID: <20171218123548.32511-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a missing ethernet 0 alisas in the devicetree on the
Nanopi M1 Plus.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 0a8b79cf5954..87509a3e6aba 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -48,6 +48,7 @@
 
 	aliases {
 		serial1 = &uart3;
+		ethernet0 = &emac;
 		ethernet1 = &sdio_wifi;
 	};
 
-- 
2.11.0
