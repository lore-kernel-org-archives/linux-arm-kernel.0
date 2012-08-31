From: Barry.Song@csr.com (Barry Song)
Date: Fri, 31 Aug 2012 17:44:56 +0800
Subject: [PATCH 2/2] ARM: timer_sp804: delete redundant HAVE_SCHED_CLOCK
 option in Kconfig
In-Reply-To: <1346406296-16223-1-git-send-email-Barry.Song@csr.com>
References: <1346406296-16223-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1346406296-16223-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c1ca9f..00ef0e0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1157,7 +1157,6 @@ config PLAT_VERSATILE
 config ARM_TIMER_SP804
 	bool
 	select CLKSRC_MMIO
-	select HAVE_SCHED_CLOCK
 
 source arch/arm/mm/Kconfig
 
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
