From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 29 Sep 2013 22:45:09 +0800
Subject: [PATCH 1/2] MAINTAINERS: ARM: SIRF: add missed drivers into maintain
 list
Message-ID: <1380465910-20786-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

here take more drivers into maintain list of CSR SiRF SoC machines.
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e61c2e8..a663819 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -829,10 +829,16 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
 S:	Maintained
 F:	arch/arm/mach-prima2/
+F:	drivers/clk/clk-prima2.c
+F:	drivers/clocksource/timer-prima2.c
+F:	drivers/clocksource/timer-marco.c
 F:	drivers/dma/sirf-dma.c
 F:	drivers/i2c/busses/i2c-sirf.c
+F:	drivers/input/misc/sirfsoc-onkey.c
+F:	drivers/irqchip/irq-sirfsoc.c
 F:	drivers/mmc/host/sdhci-sirf.c
 F:	drivers/pinctrl/sirf/
+F:	drivers/rtc/rtc-sirfsoc.c
 F:	drivers/spi/spi-sirf.c
 
 ARM/EBSA110 MACHINE SUPPORT
-- 
1.8.2.3
