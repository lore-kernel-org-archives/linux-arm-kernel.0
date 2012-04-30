From: 21cnbao@gmail.com (21cnbao at gmail.com)
Date: Mon, 30 Apr 2012 11:23:23 +0800
Subject: [PATCH] MAINTAINER: add some drivers upstreamed in CSR SIRFPRIMA2
Message-ID: <1335756203-3285-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 MAINTAINERS |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb76fc4..177d3f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -746,7 +746,10 @@ M:	Barry Song <baohua.song@csr.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-prima2/
-F:	drivers/dma/sirf-dma*
+F:	drivers/dma/sirf-dma.c
+F:	drivers/i2c/busses/i2c-sirf.c
+F:	drivers/pinctrl/pinctrl-sirf.c
+F:	drivers/spi/spi-sirf.c
 
 ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@arm.linux.org.uk>
-- 
1.7.1
