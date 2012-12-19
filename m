From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 19 Dec 2012 12:06:28 +0200
Subject: [PATCH] ARM: OMAP4: PRM: fix RSTTIME and RSTST offsets
In-Reply-To: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1355911588-21977-3-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

RSTTIME is offset 0x8 and RSTST is offset 0x04 for OMAP4430 and
OMAP4460.

Signed-off-by: Nishanth Menon <nm@ti.com>
[ivan.khoronzhuk at ti.com: ported from k3.4]
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/mach-omap2/prm44xx.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 22b0979..8ee1fbd 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -62,8 +62,8 @@
 
 /* OMAP4 specific register offsets */
 #define OMAP4_RM_RSTCTRL				0x0000
-#define OMAP4_RM_RSTTIME				0x0004
-#define OMAP4_RM_RSTST					0x0008
+#define OMAP4_RM_RSTST					0x0004
+#define OMAP4_RM_RSTTIME				0x0008
 #define OMAP4_PM_PWSTCTRL				0x0000
 #define OMAP4_PM_PWSTST					0x0004
 
-- 
1.7.9.5
