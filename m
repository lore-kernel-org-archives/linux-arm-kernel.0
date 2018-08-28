From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue, 28 Aug 2018 16:27:18 +0530
Subject: [PATCH 15/15] MAINTAINERS: Add entry for Marvell OcteonTX2 Admin
 Function driver
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1535453838-12154-16-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@marvell.com>

Added maintainers entry for Marvell OcteonTX2 SOC's RVU
admin function driver.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bef28b..99ef6c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8821,6 +8821,16 @@ S:	Supported
 F:	drivers/mmc/host/sdhci-xenon*
 F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 
+MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER
+M:	Sunil Goutham <sgoutham@marvell.com>
+M:	Linu Cherian <lcherian@marvell.com>
+M:	Geetha sowjanya <gakula@marvell.com>
+M:	Jerin Jacob <jerinj@marvell.com>
+L:	linux-kernel at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/marvell/octeontx2
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev at vger.kernel.org
 S:	Orphan
-- 
2.7.4
