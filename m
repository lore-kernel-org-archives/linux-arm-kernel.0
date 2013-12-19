From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Dec 2013 14:36:17 -0800
Subject: [PATCH 2/3] ARM: dts: Add the missing "\" key in non-US keyboards for
 exynos5250-snow
In-Reply-To: <1387492578-22068-1-git-send-email-dianders@chromium.org>
References: <1387492578-22068-1-git-send-email-dianders@chromium.org>
Message-ID: <1387492578-22068-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the exynos5250 device tree was sent upstream the keyboard mapping
was missing the 2nd instance of the "\" key.  There are two copies of
the "\" because it simply has a different row and column on US and
non-US keyboards.

For more details, see the previous patch in this series: (mkbp: Fix
problems with backslash).

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index fd711e2..28fe2e2 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -130,6 +130,7 @@
 							0x04060024	/* J */
 							0x04080027	/* ; */
 							0x04090026	/* L */
+							0x040a002b	/* \ */
 							0x040b001c	/* ENTER */
 
 							0x0501002c	/* Z */
-- 
1.8.5.1
