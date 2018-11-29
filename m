From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 29 Nov 2018 02:37:40 +0000
Subject: [PATCH V4 3/4] defconfig: arm64: add i.MX system controller thermal
 support
In-Reply-To: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1543458696-4741-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index abd80c5..9f12324 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -376,6 +376,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_IMX_SC_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
-- 
2.7.4
