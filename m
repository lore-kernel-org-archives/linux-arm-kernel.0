From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri,  1 Aug 2014 06:54:51 +0200
Subject: [PATCH v5 04/10] ARM: dts: Fill in bootargs for exynos5250-snow
In-Reply-To: <1406868897-26874-1-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
Message-ID: <1406868897-26874-5-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos5250-cros-common.dtsi had an empty /chosen node.
Fill in exemplary boot arguments.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v5: New
 Cleanup for /chosen node moved into -snow.dts.

 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 7680d5e03fb3..c4b0c73c736d 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -27,6 +27,7 @@
 	};
 
 	chosen {
+		bootargs = "console=tty1";
 	};
 
 	gpio-keys {
-- 
1.9.3
