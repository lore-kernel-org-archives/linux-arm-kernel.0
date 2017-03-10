From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Mar 2017 10:40:26 +0100
Subject: [PATCH] arm64: defconfig: Enable SH Mobile I2C controller
In-Reply-To: <cover.1489138765.git.horms+renesas@verge.net.au>
References: <cover.1489138765.git.horms+renesas@verge.net.au>
Message-ID: <58e7696e0e3c085804fb6754a7dadf7267d0fa77.1489138765.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SH Mobile I2C controller for use on R-Car Gen3 SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7c48028ec64a..95aa53112da5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -251,6 +251,7 @@ CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
+CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_RCAR=y
-- 
2.7.0.rc3.207.g0ac5344
