From: Barry.Song@csr.com (Barry Song)
Date: Fri, 31 Aug 2012 17:44:55 +0800
Subject: [PATCH 1/2] ARM: exynos: delete redundant HAVE_SCHED_CLOCK option in
 Kconfig
Message-ID: <1346406296-16223-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-exynos/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b5b4c8c..3fd4ab3 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -243,7 +243,6 @@ config MACH_UNIVERSAL_C210
 	select CPU_EXYNOS4210
 	select S5P_HRT
 	select CLKSRC_MMIO
-	select HAVE_SCHED_CLOCK
 	select S5P_GPIO_INT
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
