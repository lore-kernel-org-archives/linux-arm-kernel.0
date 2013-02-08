From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  8 Feb 2013 13:04:51 -0700
Subject: [PATCH] MAINTAINERS: add keyword "tegra" to Tegra section
Message-ID: <1360353891-24210-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The intent is to ensure that all Tegra-related patches are sent to the
linux-tegra@ mailing list, so people can keep up-to-date on all misc
driver changes.

Doing this with a keyword is far simpler and more compact than listing
all Tegra-related drivers, even if wildcards were used.

Words such as integrate or integrator are common. Use a negative look-
behind assertion to make sure the keyword doesn't match those.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 MAINTAINERS |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 972fd51..ebd3c64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7850,9 +7850,7 @@ L:	linux-tegra at vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-tegra/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
 S:	Supported
-F:	arch/arm/mach-tegra
-F:	arch/arm/boot/dts/tegra*
-F:	arch/arm/configs/tegra_defconfig
+K:	(?<!in)tegra
 
 TEHUTI ETHERNET DRIVER
 M:	Andy Gospodarek <andy@greyhouse.net>
-- 
1.7.10.4
