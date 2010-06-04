From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Jun 2010 01:51:11 -0500
Subject: [PATCH 10/10] [ARM] tegra: Add MAINTAINERS entry
Message-ID: <mailman.473.1275636244.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer entry for tegra support.

Signed-off-by: Olof Johansson <olof@lixom.net>

---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d329b05..e052077 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5396,6 +5396,13 @@ W:	http://tcp-lp-mod.sourceforge.net/
 S:	Maintained
 F:	net/ipv4/tcp_lp.c
 
+TEGRA PLATFORM SUPPORT
+M:	Olof Johansson <olof@lixom.net>
+L:	linux-tegra at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/mach-tegra/
+
 TEHUTI ETHERNET DRIVER
 M:	Alexander Indenbaum <baum@tehutinetworks.net>
 M:	Andy Gospodarek <andy@greyhouse.net>
-- 
1.5.6.5
