From: david@lechnology.com (David Lechner)
Date: Fri, 21 Oct 2016 13:36:56 -0500
Subject: [PATCH 4/5] ARM: davinci: enable LEDs default-on trigger in default
 config
In-Reply-To: <1477075018-20176-1-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
Message-ID: <1477075018-20176-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LEDs default-on trigger is nice to have. For example, it can be used
to configure a LED as a power indicator.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 9d7f0bc..e380743 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -181,6 +181,7 @@ CONFIG_LEDS_GPIO=m
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
-- 
2.7.4
