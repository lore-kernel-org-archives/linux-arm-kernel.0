From: olof@lixom.net (Olof Johansson)
Date: Fri,  7 Oct 2011 13:27:48 -0700
Subject: [PATCH] MAINTAINERS: Update tegra maintainer information
Message-ID: <1318019268-6946-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of changes to the Tegra maintainership setup:

I'm very glad to bring on Stephen Warren on board as a maintainer. The
work he has done so far is excellent, and the fact that he works for
Nvidia means he has long-term interest in the platform.

Erik Gilling did an astounding amount of work on getting things up and
running but has been a silent partner on the maintainership side for a
while, and is stepping down. Thanks for your contributions so far, Erik.

Finally, update the git URL since I'll take over running the main repo
for a while.

Overall maintainership model isn't changing much at this time: We'll all
three review patches as appropriate, and one of us will collect the main
repo (me at this time).

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Stephen Warren <swarren@nvidia.com>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ace8f9c..5483e0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6366,10 +6366,10 @@ F:	net/ipv4/tcp_lp.c
 
 TEGRA SUPPORT
 M:	Colin Cross <ccross@android.com>
-M:	Erik Gilling <konkers@android.com>
 M:	Olof Johansson <olof@lixom.net>
+M:	Stephen Warren <swarren@nvidia.com>
 L:	linux-tegra at vger.kernel.org
-T:	git git://android.git.kernel.org/kernel/tegra.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git
 S:	Supported
 F:	arch/arm/mach-tegra
 
-- 
1.7.4.1
