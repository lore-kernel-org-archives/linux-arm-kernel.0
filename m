From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 22 Sep 2009 04:07:19 +0530
Subject: [PATCH 3/3] pl022: fix peripheral id for ST vendor
Message-ID: <1253572639.21542.47.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This fixes the wrong peripheral id being used in pl022
driver for ST derivative

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 drivers/spi/amba-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index da76797..1d51b49 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1828,7 +1828,7 @@ static struct amba_id pl022_ids[] = {
 		 * ST Micro derivative, this has 32bit wide
 		 * and 32 locations deep TX/RX FIFO
 		 */
-		.id	= 0x00108022,
+		.id	= 0x01080022,
 		.mask	= 0xffffffff,
 		.data	= &vendor_st,
 	},
-- 
1.6.3.GIT
