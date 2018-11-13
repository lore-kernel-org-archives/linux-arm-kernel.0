From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 17:45:35 +0530
Subject: [PATCH v6 4/4] arm64: defconfig: Enable PWM_SUN4I
In-Reply-To: <20181113121535.24137-1-jagan@amarulasolutions.com>
References: <20181113121535.24137-1-jagan@amarulasolutions.com>
Message-ID: <20181113121535.24137-4-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner PWM support need for ARM64 Allwinner SoC's
which used pwms, builds it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- none
Changes for v5:
- new patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb614bd70716..dfdbc0646472 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -648,6 +648,7 @@ CONFIG_PWM_MESON=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
+CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
-- 
2.18.0.321.gffc6fa0e3
