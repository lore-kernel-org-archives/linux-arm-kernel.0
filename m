From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu,  3 Jun 2010 09:34:15 +0300
Subject: [PATCH 07/10] omap: mailbox cleanup: split MODULE_AUTHOR line
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Message-ID: <1275546858-29507-8-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ohad Ben-Cohen <ohad@wizery.com>

use multiple MODULE_AUTHOR lines for multiple authors

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 ++-
 arch/arm/plat-omap/mailbox.c  |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 318f363..763272c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -486,5 +486,6 @@ module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
-MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
+MODULE_AUTHOR("Paul Mundt");
 MODULE_ALIAS("platform:"DRV_NAME);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index fafe47b..66c6e87 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -430,4 +430,5 @@ module_exit(omap_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: interrupt driven messaging");
-MODULE_AUTHOR("Toshihiro Kobayashi and Hiroshi DOYU");
+MODULE_AUTHOR("Toshihiro Kobayashi");
+MODULE_AUTHOR("Hiroshi DOYU");
-- 
1.7.1.rc1
