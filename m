From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Oct 2015 16:05:27 +0200
Subject: [PATCH v2 4/4] ARM: configs: Add STM32 DMA support in STM32 defconfig
In-Reply-To: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1444745127-1105-5-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds STM32 DMA support in stm32_defconfig file

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 4725fab..ec52505 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -54,6 +54,8 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_DMADEVICES=y
+CONFIG_STM32_DMA=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-- 
1.9.1
