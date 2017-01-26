From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 09:52:26 +0100
Subject: [PATCH 1/5] arm64: defconfig: Enable SH Mobile I2C controller
In-Reply-To: <1485420750-12701-1-git-send-email-horms+renesas@verge.net.au>
References: <1485420750-12701-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1485420750-12701-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SH Mobile I2C controller for use on R-Car Gen3 SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 869dded0f09f..92a3ee26c6fd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -245,6 +245,7 @@ CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
+CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_RCAR=y
-- 
2.7.0.rc3.207.g0ac5344
