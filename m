From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 14:42:59 +0000
Subject: [PATCH 3/5] ARM: prima2_defconfig: enable build for misc input
Message-ID: <1436798579-4282-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

we need INPUT_MISC to enable INPUT_SIRFSOC_ONKEY which is the onkey
driver for SiRFSoC platforms.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index cf3acc8..88d416f 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -26,6 +26,7 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_INPUT_MISC=y
 CONFIG_SERIAL_SIRFSOC=y
 CONFIG_SERIAL_SIRFSOC_CONSOLE=y
 CONFIG_HW_RANDOM=y
-- 
2.3.5
