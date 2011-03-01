From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:00:35 +0530
Subject: [PATCH V6 11/11] ST SPEAR6xx: renaming spear600_defconfig as
	spear6xx_defconfig
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <0609ba2c1c3ec9af7ed43edafa5588d2b8a4be5b.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 .../{spear600_defconfig => spear6xx_defconfig}     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/configs/{spear600_defconfig => spear6xx_defconfig} (97%)

diff --git a/arch/arm/configs/spear600_defconfig b/arch/arm/configs/spear6xx_defconfig
similarity index 97%
rename from arch/arm/configs/spear600_defconfig
rename to arch/arm/configs/spear6xx_defconfig
index 6777c11..cef2e83 100644
--- a/arch/arm/configs/spear600_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -8,6 +8,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR6XX=y
+CONFIG_BOARD_SPEAR600_EVB=y
 CONFIG_BINFMT_MISC=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
@@ -22,7 +23,6 @@ CONFIG_MAX_RAW_DEVS=8192
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
-- 
1.7.2.2
