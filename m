From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 2 Dec 2016 15:10:01 +0100
Subject: [PATCH 8/8] ARM: configs: stm32: Add STM32 RTC support in STM32
 defconfig
In-Reply-To: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <1480687801-19525-10-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds STM32 RTC support in stm32_defconfig file.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index e7b56d4..71f9787 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -59,6 +59,8 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_STM32=y
 CONFIG_DMADEVICES=y
 CONFIG_STM32_DMA=y
 # CONFIG_FILE_LOCKING is not set
-- 
1.9.1
