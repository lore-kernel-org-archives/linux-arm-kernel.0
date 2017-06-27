From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 27 Jun 2017 11:28:03 +0200
Subject: [PATCH 3/6] arm: sun8i: orangepi-zero: use internal phy-mode
In-Reply-To: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
References: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
Message-ID: <20170627092806.28181-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the PHY used is internal, simply set phy-mode as internal.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 6713d0f2b3f4..7c154b845baa 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -106,7 +106,7 @@
 
 &emac {
 	phy-handle = <&int_mii_phy>;
-	phy-mode = "mii";
+	phy-mode = "internal";
 	allwinner,leds-active-low;
 	status = "okay";
 };
-- 
2.13.0
