From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Jul 2014 01:15:46 +0800
Subject: [PATCH v2 4/5] ARM: dts: sun6i: Add ethernet alias for GMAC
In-Reply-To: <1405444547-21870-1-git-send-email-wens@csie.org>
References: <1405444547-21870-1-git-send-email-wens@csie.org>
Message-ID: <1405444547-21870-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alias GMAC as ethernet0 so U-boot can fill in the MAC address.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 578fde2..44b07e5 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -23,6 +23,7 @@
 		serial3 = &uart3;
 		serial4 = &uart4;
 		serial5 = &uart5;
+		ethernet0 = &gmac;
 	};
 
 
-- 
2.0.1
