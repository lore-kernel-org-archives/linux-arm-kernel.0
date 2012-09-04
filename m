From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  4 Sep 2012 16:34:38 -0600
Subject: [PATCH] MAINTAINERS: tegra: remove Olof/Colin, add device tree files
Message-ID: <1346798078-28682-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

At Linux Plumbers conference, Olof and Colin both told me to remove them
from the MAINTAINERS file. Thank you both very much for all the help with
Tegra!

Also, include all Tegra-related device-tree files in the file list.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 MAINTAINERS |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae54678..7c9fdb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6776,14 +6776,13 @@ F:	drivers/net/team/
 F:	include/linux/if_team.h
 
 TEGRA SUPPORT
-M:	Colin Cross <ccross@android.com>
-M:	Olof Johansson <olof@lixom.net>
 M:	Stephen Warren <swarren@wwwdotorg.org>
 L:	linux-tegra at vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-tegra/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
 S:	Supported
 F:	arch/arm/mach-tegra
+F:	arch/arm/boot/dts/tegra*
 F:	arch/arm/configs/tegra_defconfig
 
 TEHUTI ETHERNET DRIVER
-- 
1.7.0.4
