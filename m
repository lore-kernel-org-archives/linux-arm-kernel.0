From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 29 Mar 2016 17:35:48 -0300
Subject: [PATCH 2/3] ARM: configs: Enable panic LED trigger on s3c2410
In-Reply-To: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1459283749-22451-3-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's add the panic LED trigger, which will be used by
the GTA02 board.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/arm/configs/s3c2410_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index b3ade552a2a5..81812bd5bcc7 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -385,6 +385,7 @@ CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
 CONFIG_LEDS_TRIGGER_GPIO=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
+CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_EXT2_FS=y
-- 
2.7.0
