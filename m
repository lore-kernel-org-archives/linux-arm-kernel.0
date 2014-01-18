From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:44 +0100
Subject: [RFC v3 02/13] sata-highbank: Remove unnecessary ahci_platform.h
 include
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390088935-7193-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sata-highbank driver is a complete standalone sata driver, which does
not use ahci_platform.c / ahci_platform_data in any way.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/sata_highbank.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index ea3b3dc..870b11e 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -29,7 +29,6 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
-#include <linux/ahci_platform.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/export.h>
-- 
1.8.4.2
