From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 14:07:08 +0200
Subject: [PATCH v2 3/3] ARM: multi_v7_defconfig: enable STM32 RTC
In-Reply-To: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
References: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526558828-24456-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the STM32 Real Time Clock (RTC) driver, implemented on STM32MP1 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 89167cd..8e02f86 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -863,6 +863,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_RTC_DRV_STM32=y
 CONFIG_RTC_DRV_CPCAP=m
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
-- 
2.7.4
