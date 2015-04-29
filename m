From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Apr 2015 16:18:37 -0500
Subject: [PATCH 1/1] ARM: imx: Remove the duplicated function declaration
Message-ID: <1430342317-57255-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed the duplicated function declaration of mxc_timer_init
which was already declared in drivers/clk/imx/clk.h.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index d1e2873..029f6f0 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -44,7 +44,6 @@ void imx27_soc_init(void);
 void imx31_soc_init(void);
 void imx35_soc_init(void);
 void epit_timer_init(void __iomem *base, int irq);
-void mxc_timer_init(unsigned long, int);
 int mx1_clocks_init(unsigned long fref);
 int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
-- 
1.9.1
