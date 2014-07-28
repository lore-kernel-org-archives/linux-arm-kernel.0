From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jul 2014 12:06:26 -0600
Subject: [PATCH] MAINTAINERS: Update Tegra Git URL
Message-ID: <1406570786-10432-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

swarren/linux-tegra.git is a stale location; it has moved to
tegra/linux.git.

While the git protocol re-directs to the new location, HTTP does not.
Besides, MAINTAINERS should contain the canonical URL.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
[swarren, updated commit message]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86efa7e213c2..dcda974bd7ec 100644
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
1.9.1
