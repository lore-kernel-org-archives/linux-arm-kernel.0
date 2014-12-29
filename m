From: alexanders83@web.de (Alexander Stein)
Date: Mon, 29 Dec 2014 13:08:42 +0100
Subject: [PATCH v3] ARM: at91/defconfig: add SND_ATMEL_AC97C to at91_dt
In-Reply-To: <1419854922-29338-1-git-send-email-alexanders83@web.de>
References: <1419854922-29338-1-git-send-email-alexanders83@web.de>
Message-ID: <1419854922-29338-4-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This chip is present on at91sam9263: add it to the at91_dt_defconfig.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
Changes in v3:
* Added to patch series

 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index a67375f..932a34b 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -147,6 +147,7 @@ CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
+CONFIG_SND_ATMEL_AC97C=y
 CONFIG_SND_SOC=y
 CONFIG_SND_ATMEL_SOC=y
 CONFIG_SND_AT91_SOC_SAM9G20_WM8731=y
-- 
2.2.1
