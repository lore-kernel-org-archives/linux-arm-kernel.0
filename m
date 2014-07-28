From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Jul 2014 19:30:42 +0200
Subject: [PATCH] MAINTAINERS: Update Tegra Git URL
Message-ID: <1406568643-2047-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

swarren/linux-tegra.git does not exist, it's tegra/linux.git.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86efa7e..dcda974 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8922,7 +8922,7 @@ M:	Stephen Warren <swarren@wwwdotorg.org>
 M:	Thierry Reding <thierry.reding@gmail.com>
 L:	linux-tegra at vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-tegra/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
 S:	Supported
 N:	[^a-z]tegra
 
-- 
2.0.1
