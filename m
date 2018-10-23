From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Oct 2018 13:06:08 +0200
Subject: [PATCH 3/3] spi: bcm2835: make license text and module license match
In-Reply-To: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
References: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540292769-5905-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The license text is specifying GPL v2 or later but the MODULE_LICENSE
is set to GPL v2 which means GNU Public License v2 only. So choose the
license text as the correct one.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/spi/spi-bcm2835.c    | 2 +-
 drivers/spi/spi-bcm2835aux.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index f35cc10..b0b87ff 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -843,4 +843,4 @@ module_platform_driver(bcm2835_spi_driver);
 
 MODULE_DESCRIPTION("SPI controller driver for Broadcom BCM2835");
 MODULE_AUTHOR("Chris Boot <bootc@bootc.net>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 3094d81..671e374 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -542,4 +542,4 @@ module_platform_driver(bcm2835aux_spi_driver);
 
 MODULE_DESCRIPTION("SPI controller driver for Broadcom BCM2835 aux");
 MODULE_AUTHOR("Martin Sperl <kernel@martin.sperl.org>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.7.4
