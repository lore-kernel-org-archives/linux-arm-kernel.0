From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Tue, 21 Mar 2017 16:13:31 +0100
Subject: [PATCH v2 5/5] ARM: configs: stm32: Add crypto support
In-Reply-To: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
References: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <1490109211-4869-6-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add STM32 crypto support in stm32_defconfig file.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a9d8e3c..03437f8 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -75,5 +75,7 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_DEV_STM32=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
-- 
2.7.4
