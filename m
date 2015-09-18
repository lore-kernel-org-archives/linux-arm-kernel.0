From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Sep 2015 16:00:46 +0800
Subject: [PATCH] ARM: sunxi: Add sun[89]i to MAINTAINERS entry
Message-ID: <1442563246-7133-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer Allwinner SoCs fall under sun8i or sun9i families. Update
the MAINTAINERS entry to include them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab749c85..2e436a937c96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -892,7 +892,7 @@ ARM/Allwinner A1X SoC support
 M:	Maxime Ripard <maxime.ripard@free-electrons.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-N:	sun[x4567]i
+N:	sun[x456789]i
 
 ARM/Allwinner SoC Clock Support
 M:	Emilio L?pez <emilio@elopez.com.ar>
-- 
2.5.1
