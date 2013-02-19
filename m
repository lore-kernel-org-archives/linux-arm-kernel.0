From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 12:24:24 +0200
Subject: [PATCH 2/2] arm: omap2: voltage: remove unnecessary header
In-Reply-To: <1361269464-20263-1-git-send-email-balbi@ti.com>
References: <1361269464-20263-1-git-send-email-balbi@ti.com>
Message-ID: <1361269464-20263-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nothing from <linux/debugfs.h> is used on
voltage.c.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/voltage.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 3ac8fe1..595bf1a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 
-- 
1.8.1.rc1.5.g7e0651a
