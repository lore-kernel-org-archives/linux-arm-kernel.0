From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed,  7 Dec 2016 19:18:35 +0200
Subject: [PATCH] MAINTAINERS: Add Patchwork URL to Samsung Exynos entry
Message-ID: <1481131115-11143-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I use Patchwork for handling incoming patches. Put its address here so
submitters could know what is in the queue.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 191887bdc49b..ec5137c39572 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1689,6 +1689,7 @@ M:	Krzysztof Kozlowski <krzk@kernel.org>
 R:	Javier Martinez Canillas <javier@osg.samsung.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
+Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
 S:	Maintained
 F:	arch/arm/boot/dts/s3c*
 F:	arch/arm/boot/dts/s5p*
-- 
2.7.4
