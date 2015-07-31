From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:28 +0200
Subject: [PATCH 7/9] ARM: at91/defconfig: at91_dt: remove ARM_AT91_ETHER
In-Reply-To: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438383510-10521-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_ARM_AT91_ETHER doesn't exist anymore, both drivers have been merged
in the macb driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index ace0e5d3ed6b..0065411bf3ca 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -73,7 +73,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_ARM_AT91_ETHER=y
 CONFIG_MACB=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
 CONFIG_DM9000=y
-- 
2.1.4
