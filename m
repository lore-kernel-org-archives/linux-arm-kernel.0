From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  5 Jan 2015 12:53:02 +0100
Subject: [PATCH] ARM: configs: at91_dt: add rm9200 ethernet support
Message-ID: <1420458782-22812-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is now only on defconfig for the at91rm9200 and at91sam9. Add ethernet
support for the rm9200.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index a67375f24b21..8116d122e098 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -78,6 +78,7 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+CONFIG_ARM_AT91_ETHER=y
 CONFIG_MACB=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
 CONFIG_DM9000=y
-- 
2.1.0
