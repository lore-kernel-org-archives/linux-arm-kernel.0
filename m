From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 30 May 2011 12:51:04 +0530
Subject: [PATCH 3/3] SPEAr3xx: Update defconfig for ST's PWM
In-Reply-To: <cover.1306739836.git.viresh.kumar@st.com>
References: <cover.1306739836.git.viresh.kumar@st.com>
Message-ID: <f56b06e5ea5d700ac72a203525d9670da66cbab9.1306739836.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/configs/spear3xx_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 07e9613..34c0ac2 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -14,6 +14,8 @@ CONFIG_BINFMT_MISC=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_MISC_DEVICES=y
+CONFIG_ST_PWM=y
 CONFIG_INPUT_FF_MEMLESS=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
-- 
1.7.2.2
