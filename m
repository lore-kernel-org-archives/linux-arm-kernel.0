From: lho@apm.com (Loc Ho)
Date: Sat, 23 Aug 2014 01:23:05 -0600
Subject: [PATCH v5 1/4] MAINTAINERS: Add entry for APM X-Gene SoC EDAC driver
In-Reply-To: <1408778588-3215-1-git-send-email-lho@apm.com>
References: <1408778588-3215-1-git-send-email-lho@apm.com>
Message-ID: <1408778588-3215-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MAINTAINERS entry for APM X-Gene SoC EDAC driver.

Signed-off-by: Loc Ho <lho@apm.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca2b31c..435b53a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3427,6 +3427,14 @@ W:	bluesmoke.sourceforge.net
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
1.5.5
