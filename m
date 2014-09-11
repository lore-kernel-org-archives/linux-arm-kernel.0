From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 11:56:58 +0200
Subject: [PATCH 3/4] ARM: mvebu: add LED class support built-in in
 mvebu_v7_defconfig
In-Reply-To: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1410429419-29820-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason, while all other features are configured built-in, the
LED class support was configured as a module in
mvebu_v7_defconfig. This commit makes it consistent with the other
options, by making this feature built-in.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index fdfda1f..3469c3d9 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -98,7 +98,7 @@ CONFIG_MMC_SDHCI_PXAV3=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-- 
2.0.0
