From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Sep 2013 14:04:51 +0200
Subject: [PATCH] ARM: imx: Include linux/err.h
Message-ID: <1380542691-24756-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IS_ERR() macro is defined in the linux/err.h header file, so include
it explicitly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-imx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index fae2c9a..ba3b498 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -1,4 +1,4 @@
-
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
-- 
1.8.4
