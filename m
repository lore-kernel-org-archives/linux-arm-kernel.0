From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Aug 2014 14:19:45 -0400
Subject: [Patch v3 6/6] MAINTAINERS: Add Keystone Multicore Navigator drivers
 entry
In-Reply-To: <1407521985-22574-1-git-send-email-santosh.shilimkar@ti.com>
References: <1407521985-22574-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1407521985-22574-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2066f4..e5b1179 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9051,6 +9051,15 @@ F:	drivers/misc/tifm*
 F:	drivers/mmc/host/tifm_sd.c
 F:	include/linux/tifm.h
 
+TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
+M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
+L:	linux-kernel at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/ti/*
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
+
+
 TI LM49xxx FAMILY ASoC CODEC DRIVERS
 M:	M R Swami Reddy <mr.swami.reddy@ti.com>
 M:	Vishwas A Deshpande <vishwas.a.deshpande@ti.com>
-- 
1.7.9.5
