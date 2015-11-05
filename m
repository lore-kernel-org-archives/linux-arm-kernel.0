From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 5 Nov 2015 15:37:56 +0800
Subject: [PATCH] ARM: at91/sama5_defconfig: enable watchdog driver
Message-ID: <1446709076-24359-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabel AT91SAM9X / AT91CAP9 watchdog and SAMA5D4 watchdog.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/configs/sama5_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index a0c57ac..963daae 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -130,6 +130,9 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
 CONFIG_SSB=m
+CONFIG_WATCHDOG=y
+CONFIG_AT91SAM9X_WATCHDOG=y
+CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
1.7.9.5
