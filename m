From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 31 Mar 2016 17:09:39 +0200
Subject: [PATCH v2 9/9] ARM: config: Enable GPIO Key driver in stm32_defconfig
In-Reply-To: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1459436979-17275-10-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/configs/stm32_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 1e5ec2a0e4cf..e7b56d4f1798 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -38,7 +38,11 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_BLK_DEV is not set
 CONFIG_EEPROM_93CX6=y
-# CONFIG_INPUT is not set
+# CONFIG_INPUT_LEDS is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
-- 
1.9.1
