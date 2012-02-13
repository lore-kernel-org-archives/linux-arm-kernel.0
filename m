From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Feb 2012 06:10:26 -0800
Subject: [PATCH] MAINTAINERS: remove arch/arm/mach-mx*/ from IMX entry
Message-ID: <1329142226-2685-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 784a90c0a7d8f5 ("ARM i.MX: Merge i.MX5 support into
mach-imx") merging mach-mx5 into mach-imx, arch/arm/mach-mx* only
covers mach-mxs now.  Since we already have a separate MXS entry
for arch/arm/mach-mxs, arch/arm/mach-mx* can simply be removed there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 MAINTAINERS |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55ca0be..37169f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -785,7 +785,6 @@ M:	Sascha Hauer <kernel@pengutronix.de>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
-F:	arch/arm/mach-mx*/
 F:	arch/arm/mach-imx/
 F:	arch/arm/plat-mxc/
 
-- 
1.7.5.4
