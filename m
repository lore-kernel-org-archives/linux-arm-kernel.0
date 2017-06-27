From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 27 Jun 2017 11:28:05 +0200
Subject: [PATCH 5/6] arm: sun8i: nanopi-neo: use internal phy-mode
In-Reply-To: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
References: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
Message-ID: <20170627092806.28181-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the PHY used is internal, simply set phy-mode as internal.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 78f6c24952dd..5c5ba806e2f1 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -49,7 +49,7 @@
 
 &emac {
 	phy-handle = <&int_mii_phy>;
-	phy-mode = "mii";
+	phy-mode = "internal";
 	allwinner,leds-active-low;
 	status = "okay";
 };
-- 
2.13.0
