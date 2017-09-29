From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:10 +0200
Subject: [PATCH 2/3] arm64: defconfig: enable thermal driver for Renesas R-Car
 Gen3
In-Reply-To: <cover.1506678593.git.horms+renesas@verge.net.au>
References: <cover.1506678593.git.horms+renesas@verge.net.au>
Message-ID: <86f0a075111d16e3b48d79b44858e141ea86cad7.1506678593.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We want this driver to detect critical temperatures in time.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a83012a7f4b8..1eb054469927 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -316,6 +316,7 @@ CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
-- 
2.1.4
