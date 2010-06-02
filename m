From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  2 Jun 2010 10:40:47 +0300
Subject: [PATCH 2/5] usb/otg/ulpi: add support for SMSC USB3319 ulpi phy.
In-Reply-To: <1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/usb/otg/ulpi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
index 0e7a826..99756ab 100644
--- a/drivers/usb/otg/ulpi.c
+++ b/drivers/usb/otg/ulpi.c
@@ -59,6 +59,7 @@
 /* ULPI hardcoded IDs, used for probing */
 static unsigned int ulpi_ids[] = {
 	ULPI_ID(0x04cc, 0x1504),	/* NXP ISP1504 */
+	ULPI_ID(0x0424, 0x0006),        /* SMSC USB3319 */
 };
 
 static int ulpi_set_otg_flags(struct otg_transceiver *otg)
-- 
1.6.4.4
