From: lho@apm.com (Loc Ho)
Date: Fri, 22 May 2015 17:32:57 -0600
Subject: [PATCH v11 2/5] MAINTAINERS: Add entry for APM X-Gene SoC EDAC driver
In-Reply-To: <1432337580-3750-2-git-send-email-lho@apm.com>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <1432337580-3750-2-git-send-email-lho@apm.com>
Message-ID: <1432337580-3750-3-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MAINTAINERS entry for APM X-Gene SoC EDAC driver.

Signed-off-by: Loc Ho <lho@apm.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00a586b..0134fee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3735,6 +3735,13 @@ W:	bluesmoke.sourceforge.net
 S:	Maintained
 F:	drivers/edac/sb_edac.c
 
+EDAC-XGENE
+APPLIED MICRO (APM) X-GENE SOC EDAC
+M:     Loc Ho <lho@apm.com>
+S:     Supported
+F:     drivers/edac/xgene_edac.c
+F:     Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-- 
1.7.1
