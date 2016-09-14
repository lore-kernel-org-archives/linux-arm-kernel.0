From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Sep 2016 10:21:45 -0700
Subject: [PATCH] arm64: defconfig: enable meson I2C
Message-ID: <20160914172145.17799-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 17d26e958a3a..8fa341d645ee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -181,6 +181,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_IMX=y
+CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_TEGRA=y
-- 
2.9.3
