From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:41:16 -0500
Subject: [PATCH 5/5] MAINTAINERS: Add keystone clock drivers
In-Reply-To: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385250076-9596-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25b945b..249651f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1013,6 +1013,7 @@ M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-keystone/
+F:	drivers/clk/keystone/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
 
 ARM/LOGICPD PXA270 MACHINE SUPPORT
-- 
1.7.9.5
