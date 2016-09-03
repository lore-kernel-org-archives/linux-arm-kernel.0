From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Sep 2016 17:11:49 -0700
Subject: [PATCH] arm64: defconfig: enable meson WDT as modules
In-Reply-To: <20160903001149.32130-1-khilman@baylibre.com>
References: <20160903001149.32130-1-khilman@baylibre.com>
Message-ID: <20160903001149.32130-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4bc1af4ae162..2d6576fe6057 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -220,6 +220,8 @@ CONFIG_EXYNOS_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
 CONFIG_S3C2410_WATCHDOG=y
+CONFIG_MESON_GXBB_WATCHDOG=m
+CONFIG_MESON_WATCHDOG=m
 CONFIG_MFD_MAX77620=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_SEC_CORE=y
-- 
2.9.3
