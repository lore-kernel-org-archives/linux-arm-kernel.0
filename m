From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  3 Oct 2014 09:50:32 -0600
Subject: [PATCH V2 1/2] MAINTAINERS: add Alexandre Courbot for Tegra
Message-ID: <1412351433-4003-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

I'd like to propose Alexandre Courbot as an additional Tegra maintainer.
He's been working on a variety of Tegra-related code for a while, and
is now officially tasked with working on upstream support.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
--
v2:
* Use Alexandre's full name.
* Use a non-NVIDIA email address to avoid Exchange Server patch corruption.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37054306dc9f..2210990fc3c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9008,6 +9008,7 @@ F:	drivers/media/rc/ttusbir.c
 TEGRA ARCHITECTURE SUPPORT
 M:	Stephen Warren <swarren@wwwdotorg.org>
 M:	Thierry Reding <thierry.reding@gmail.com>
+M:	Alexandre Courbot <gnurou@gmail.com>
 L:	linux-tegra at vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-tegra/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
-- 
1.9.1
