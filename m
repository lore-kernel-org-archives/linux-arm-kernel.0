From: lho@apm.com (Loc Ho)
Date: Tue, 17 Mar 2015 00:30:18 -0600
Subject: [PATCH v6 2/5] MAINTAINERS: Add entry for APM X-Gene SoC EDAC driver
In-Reply-To: <1426573821-1937-2-git-send-email-lho@apm.com>
References: <1426573821-1937-1-git-send-email-lho@apm.com>
 <1426573821-1937-2-git-send-email-lho@apm.com>
Message-ID: <1426573821-1937-3-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MAINTAINERS entry for APM X-Gene SoC EDAC driver.

Signed-off-by: Loc Ho <lho@apm.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd88eb6..d67ab7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3724,6 +3724,14 @@ W:	bluesmoke.sourceforge.net
 S:	Maintained
 F:	drivers/edac/sb_edac.c

+EDAC-XGENE
+APPLIED MICRO (APM) X-GENE SOC EDAC
+M:     Loc Ho <lho@apm.com>
+M:     Feng Kan <fkan@apm.com>
+S:     Supported
+F:     drivers/edac/xgene_edac.c
+F:     Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
--
1.7.1
