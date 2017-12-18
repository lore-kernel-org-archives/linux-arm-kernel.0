From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 18 Dec 2017 16:17:50 +0100
Subject: [PATCH V2 7/9] ARM: configs: multi_v7: add stm32 support
In-Reply-To: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1513610272-7824-8-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds stm32 support to multi_v7_defconfig

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 11e648a..a0163e7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -77,6 +77,7 @@ CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 CONFIG_ARCH_STI=y
+CONFIG_ARCH_STM32=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_EXYNOS5420_MCPM=y
 CONFIG_ARCH_RENESAS=y
@@ -324,6 +325,8 @@ CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
 CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
 CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
+CONFIG_SERIAL_STM32=y
+CONFIG_SERIAL_STM32_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_ST=y
-- 
2.7.4
