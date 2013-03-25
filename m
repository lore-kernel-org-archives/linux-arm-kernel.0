From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:35 -0300
Subject: [PATCH 8/17] ARM: mach-imx: clk-gate2: Include "clk.h"
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-8-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/clk-gate2.c:86:12: warning: symbol 'clk_register_gate2' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-gate2.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index cc49c7a..a63e415 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/string.h>
+#include "clk.h"
 
 /**
  * DOC: basic gatable clock which can gate and ungate it's ouput
-- 
1.7.9.5
