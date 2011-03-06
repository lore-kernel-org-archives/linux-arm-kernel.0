From: alberto@amarulasolutions.com (Alberto Panizzo)
Date: Sun, 06 Mar 2011 16:39:15 +0100
Subject: [PATCH 1/4] spi_imx: Fix misspelled configuration variable SOC_IMX31
In-Reply-To: <1299425878.2624.29.camel@realization>
References: <1299425878.2624.29.camel@realization>
Message-ID: <1299425955.2624.30.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bd9dad5..996cf03 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -161,7 +161,7 @@ config SPI_IMX_VER_0_0
 	def_bool y if SOC_IMX21 || SOC_IMX27
 
 config SPI_IMX_VER_0_4
-	def_bool y if SOC_MX31
+	def_bool y if SOC_IMX31
 
 config SPI_IMX_VER_0_7
 	def_bool y if ARCH_MX25 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
-- 
1.7.1
