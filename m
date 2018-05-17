From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 16:21:44 +0200
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: enable STM32 SPI
In-Reply-To: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
References: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526566904-24514-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the STM32 SPI driver, implemented on STM32MP1 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 89167cd..f990335 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -411,6 +411,7 @@ CONFIG_SPI_S3C64XX=m
 CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SH_HSPI=y
 CONFIG_SPI_SIRF=y
+CONFIG_SPI_STM32=y
 CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA114=y
-- 
2.7.4
