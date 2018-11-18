From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 18 Nov 2018 14:10:04 +0100
Subject: [PATCH RESEND 07/17] firmware: raspberrypi: Switch to SPDX identifier
Message-ID: <1542546604-27728-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Eric Anholt <eric@anholt.net>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/firmware/raspberrypi.c             | 5 +----
 include/soc/bcm2835/raspberrypi-firmware.h | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

Hi, it seems that i forgot to send this patch last week.

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index bf45ac4..f8de8b4 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Defines interfaces for interacting wtih the Raspberry Pi firmware's
  * property channel.
  *
  * Copyright ? 2015 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/dma-mapping.h>
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index c4a5c9e..78e6031 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  Copyright ? 2015 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __SOC_RASPBERRY_FIRMWARE_H__
-- 
2.7.4
