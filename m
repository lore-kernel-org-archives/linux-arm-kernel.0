From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Nov 2011 11:16:15 +0000
Subject: [PATCH 1/2] MAINTAINERS: Add linux-samsung-soc mailing list for
 Samsung
Message-ID: <1320923776-26626-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a Samsung-specific mailing list but it's not advertised in
MAINTAINERS - add it to the overall architecture to make it more
discoverable.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c18b278..a21d4fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1046,6 +1046,7 @@ ARM/SAMSUNG ARM ARCHITECTURES
 M:	Ben Dooks <ben-linux@fluff.org>
 M:	Kukjin Kim <kgene.kim@samsung.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-samsung-soc at vger.kernel.org
 W:	http://www.fluff.org/ben/linux/
 S:	Maintained
 F:	arch/arm/plat-samsung/
-- 
1.7.7.2
