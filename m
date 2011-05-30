From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 30 May 2011 12:09:42 +0530
Subject: [PATCH 3/3] SPEAr3xx: Update defconfig for plgpio
In-Reply-To: <cover.1306737135.git.viresh.kumar@st.com>
References: <cover.1306737135.git.viresh.kumar@st.com>
Message-ID: <aae9831d70c25a49a437f9471e4499ea8feaf89d.1306737135.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/configs/spear3xx_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index fea7e1f..07e9613 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -26,6 +26,7 @@ CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=8192
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
+CONFIG_SPEAR_PLGPIO=y
 # CONFIG_HWMON is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
-- 
1.7.2.2
