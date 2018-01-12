From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 12 Jan 2018 13:16:06 +0100
Subject: [PATCH 12/14] ARM: configs: stm32: Enable EXT3_FS support
In-Reply-To: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515759368-16946-13-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Enable EXT3_FS support to be able to read rootfs from MMC partition
formatted in EXT2/3/4 .

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 8b64a9e..b736823 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -72,6 +72,7 @@ CONFIG_STM32_MDMA=y
 CONFIG_IIO=y
 CONFIG_STM32_ADC_CORE=y
 CONFIG_STM32_ADC=y
+CONFIG_EXT3_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-- 
1.9.1
