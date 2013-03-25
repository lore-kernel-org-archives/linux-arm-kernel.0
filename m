From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:31 -0300
Subject: [PATCH 4/17] ARM: mach-imx: cpu-imx5: Include "common.h"
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings:

arch/arm/mach-imx/cpu-imx5.c:65:12: warning: symbol 'mx51_neon_fixup' was not declared. Should it be static?
arch/arm/mach-imx/cpu-imx5.c:99:5: warning: symbol 'mx53_revision' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/cpu-imx5.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index d7ce722..c1c99a7 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 
 #include "hardware.h"
+#include "common.h"
 
 static int mx5_cpu_rev = -1;
 
-- 
1.7.9.5
