From: david@lechnology.com (David Lechner)
Date: Thu,  5 Jan 2017 22:33:47 -0600
Subject: [PATCH v2 4/5] ARM: davinci_all_defconfig: enable pwm-beeper
In-Reply-To: <1483677228-2325-1-git-send-email-david@lechnology.com>
References: <1483677228-2325-1-git-send-email-david@lechnology.com>
Message-ID: <1483677228-2325-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the pwm-beeper module. This is used by the speaker on LEGO
MINDSTORMS EV3.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a899876..e046fd7 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -100,6 +100,7 @@ CONFIG_KEYBOARD_XTKBD=m
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_PWM_BEEPER=m
 CONFIG_INPUT_DM355EVM=m
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_VT_CONSOLE is not set
-- 
2.7.4
