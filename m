From: joyce.ooi@intel.com (Ooi, Joyce)
Date: Thu, 15 Feb 2018 11:20:28 +0800
Subject: [PATCH] arm64: defconfig: enable CONFIG_LEDS_TRIGGER_TIMER
Message-ID: <1518664828-30883-1-git-send-email-joyce.ooi@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable LED timer trigger for ARM64 to allow LEDs to be controlled via
sysfs.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 arch/arm64/configs/defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..b728742 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -471,6 +471,8 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
 CONFIG_LEDS_SYSCON=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-- 
1.7.1
