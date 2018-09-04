From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue,  4 Sep 2018 17:24:50 +0530
Subject: [PATCH v2 15/15] MAINTAINERS: Add entry for Marvell OcteonTX2 Admin
 Function driver
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1536062090-30446-16-git-send-email-sunil.kovvuri@gmail.com>
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
index e178f2b..38f874c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8748,6 +8748,16 @@ S:	Supported
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
