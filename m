From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Thu, 5 Jul 2018 11:05:32 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 DCMI media support
Message-ID: <1530781532-7125-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables support of STM32 DCMI V4L2 media driver.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f6be19..42ad73f76 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -578,6 +578,7 @@ CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_STI_BDISP=m
 CONFIG_VIDEO_STI_HVA=m
 CONFIG_VIDEO_STI_DELTA=m
+CONFIG_VIDEO_STM32_DCMI=m
 CONFIG_VIDEO_RENESAS_JPU=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_V4L_TEST_DRIVERS=y
-- 
1.9.1
