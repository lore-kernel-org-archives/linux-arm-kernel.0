From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Oct 2018 13:06:07 +0200
Subject: [PATCH 2/3] dma: bcm2835: make license text and module license match
In-Reply-To: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
References: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540292769-5905-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The license text is specifying GPL v2 or later but the MODULE_LICENSE
is set to GPL v2 which means GNU Public License v2 only. So choose the
license text as the correct one.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 847f84a..112b071 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -1064,4 +1064,4 @@ module_platform_driver(bcm2835_dma_driver);
 MODULE_ALIAS("platform:bcm2835-dma");
 MODULE_DESCRIPTION("BCM2835 DMA engine driver");
 MODULE_AUTHOR("Florian Meier <florian.meier@koalo.de>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.7.4
