From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 9 Sep 2016 16:42:04 +0200
Subject: [PATCH v5 9/9] ARM: config: Enable GPIO Key driver in stm32_defconfig
In-Reply-To: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473432124-6784-10-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 1e5ec2a..e7b56d4 100644
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
