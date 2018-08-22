From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 22 Aug 2018 12:49:49 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: enable STM32 SPI
Message-ID: <1534934989-22292-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the STM32 SPI driver, implemented on STM32MP1 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b749d1e..4cdb622 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -417,6 +417,7 @@ CONFIG_SPI_S3C64XX=m
 CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SH_HSPI=y
 CONFIG_SPI_SIRF=y
+CONFIG_SPI_STM32=m
 CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA114=y
-- 
2.7.4
