From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 15 Jul 2010 16:00:14 +0300
Subject: [PATCH 1/3] usb/otg/ulpi: remove unused macro
In-Reply-To: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1279198816-30367-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/usb/otg/ulpi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
index 10a1df6..448d643 100644
--- a/drivers/usb/otg/ulpi.c
+++ b/drivers/usb/otg/ulpi.c
@@ -31,8 +31,6 @@
 
 #define ULPI_ID(vendor, product) (((vendor) << 16) | (product))
 
-#define TR_FLAG(flags, a, b)	(((flags) & a) ? b : 0)
-
 /* ULPI hardcoded IDs, used for probing */
 static unsigned int ulpi_ids[] = {
 	ULPI_ID(0x04cc, 0x1504),	/* NXP ISP1504 */
-- 
1.7.1
