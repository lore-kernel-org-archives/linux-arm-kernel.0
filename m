From: colin.king@canonical.com (Colin King)
Date: Sun, 29 Apr 2018 13:10:56 +0100
Subject: [PATCH] ARM: sun8i: v3s: fix spelling mistake: "disbaled" ->
 "disabled"
Message-ID: <20180429121056.10501-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in status text string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index d1311098ea45..ad173605b1b8 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -51,7 +51,7 @@
 
 	leds {
 		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
-		status = "disbaled";
+		status = "disabled";
 	};
 };
 
-- 
2.17.0
