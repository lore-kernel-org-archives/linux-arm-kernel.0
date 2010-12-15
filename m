From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Wed, 15 Dec 2010 08:36:02 +0100
Subject: [PATCH] ARM: ux500: platsmp: Fix section mismatch
Message-ID: <1292398562-12527-1-git-send-email-jonas.aberg@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
---
 arch/arm/mach-ux500/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 9e4c678..ade2e17 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -26,7 +26,7 @@
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
  */
-volatile int __cpuinitdata pen_release = -1;
+volatile int pen_release = -1;
 
 static unsigned int __init get_core_count(void)
 {
-- 
1.6.3.3
