From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 May 2016 12:07:31 -0700
Subject: [PATCH 6/7] ARM: multi_v7_defconfig: Enable Broadcom Kona watchdog
In-Reply-To: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
References: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1463771252-12805-7-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to get rid of bcm_defconfig, enable this driver which is needed
by some Broadcom SoCs based on the Kona architecture to reboot.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b59081bda51b..d180b6694374 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -458,6 +458,7 @@ CONFIG_DW_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM7038_WDT=m
+CONFIG_BCM_KONA_WDT=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
-- 
2.7.4
