From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  2 Aug 2014 02:52:25 +0200
Subject: [PATCH v6 05/10] ARM: dts: Fill in bootargs for exynos5250-snow
In-Reply-To: <1406940750-15880-1-git-send-email-afaerber@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
Message-ID: <1406940750-15880-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos5250-cros-common.dtsi had an empty /chosen node.
Fill in exemplary boot arguments.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v5 -> v6: Unchanged

 v5: New
 Cleanup for /chosen node moved into -snow.dts.

 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 40cad43f8a11..8d8e62de86c7 100644
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
