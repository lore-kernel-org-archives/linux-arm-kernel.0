From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 31 May 2011 14:21:53 +0530
Subject: [PATCH V2 3/3] SPEAr3xx: Update defconfig for ST's PWM
In-Reply-To: <cover.1306831238.git.viresh.kumar@st.com>
References: <cover.1306831238.git.viresh.kumar@st.com>
Message-ID: <1db14f78b567763df5dc344905c3d84bd79532d7.1306831238.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/configs/spear3xx_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 07e9613..bc29eaf 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -30,6 +30,8 @@ CONFIG_SPEAR_PLGPIO=y
 # CONFIG_HWMON is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_PWMLIB=y
+CONFIG_ST_PWM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_SECURITY=y
-- 
1.7.2.2
