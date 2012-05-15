From: Barry.Song@csr.com (Barry Song)
Date: Tue, 15 May 2012 10:35:46 +0800
Subject: [PATCH] ARM: PRIMA2: select PINCTRL and PINCTRL_SIRF in Kconfig
Message-ID: <1337049346-32726-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 36586db..8dfbecd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -407,6 +407,8 @@ config ARCH_PRIMA2
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
 	select MIGHT_HAVE_CACHE_L2X0
+	select PINCTRL
+	select PINCTRL_SIRF
 	select USE_OF
 	select ZONE_DMA
 	help
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
