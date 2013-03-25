From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:32 -0300
Subject: [PATCH 5/17] ARM: mach-imx: cpu_op-mx51: Include "cpu_op-mx51.h"
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-5-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/cpu_op-mx51.c:27:15: warning: symbol 'mx51_get_cpu_op' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/cpu_op-mx51.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu_op-mx51.c b/arch/arm/mach-imx/cpu_op-mx51.c
index b9ef692..d6012b8 100644
--- a/arch/arm/mach-imx/cpu_op-mx51.c
+++ b/arch/arm/mach-imx/cpu_op-mx51.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 
 #include "hardware.h"
+#include "cpu_op-mx51.h"
 
 static struct cpu_op mx51_cpu_op[] = {
 	{
-- 
1.7.9.5
