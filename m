From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 17 Aug 2017 09:51:46 +0200
Subject: [PATCH v2 3/6] ARM: sun8i: nanopi-neo: Set phy-is-integrated to the
 internal phy node
In-Reply-To: <20170817075149.16178-1-clabbe.montjoie@gmail.com>
References: <20170817075149.16178-1-clabbe.montjoie@gmail.com>
Message-ID: <20170817075149.16178-4-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the new phy-is-integrated property to the internal PHY node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 78f6c24952dd..e77b51c98374 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -53,3 +53,7 @@
 	allwinner,leds-active-low;
 	status = "okay";
 };
+
+&int_mii_phy {
+	phy-is-integrated;
+};
-- 
2.13.0
