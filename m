From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Mar 2012 10:44:11 -0700
Subject: [PATCH] ARM: tegra: update main repo and add patchwork
Message-ID: <1332092651-25346-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen is taking over the main tegra repo, so change the entry to point at his tree on kernel.org

Also, document the patchwork URL.

Signed-off-by: Olof Johansson <olof@lixom.net>
---


Arnd, I applied the previous Tegra maintainer patch to next/maintainers
directly, so this should just go on top of there.


Thanks!


-Olof


 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 187d855..a23a635 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6515,7 +6515,8 @@ M:	Colin Cross <ccross@android.com>
 M:	Olof Johansson <olof@lixom.net>
 M:	Stephen Warren <swarren@wwwdotorg.org>
 L:	linux-tegra at vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git
+Q:	http://patchwork.ozlabs.org/project/linux-tegra/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
 S:	Supported
 F:	arch/arm/mach-tegra
 
-- 
1.7.10.rc1
