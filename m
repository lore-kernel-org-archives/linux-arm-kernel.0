From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  7 Oct 2015 18:39:40 +0100
Subject: [PATCH] MAINTAINERS: Update Allwinner entry and add new maintainer
Message-ID: <1444239580-32688-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Chen-Yu Tsai as a co-maintainer to the ARM sunxi support.

While we are doing so, also update the entry for new SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 797236befd27..d6a9a016f3d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -894,11 +894,12 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
-ARM/Allwinner A1X SoC support
+ARM/Allwinner sunXi SoC support
 M:	Maxime Ripard <maxime.ripard@free-electrons.com>
+M:	Chen-Yu Tsai <wens@csie.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-N:	sun[x4567]i
+N:	sun[x456789]i
 
 ARM/Allwinner SoC Clock Support
 M:	Emilio L?pez <emilio@elopez.com.ar>
-- 
2.5.3
