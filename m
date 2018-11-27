From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 27 Nov 2018 06:13:59 +0000
Subject: [PATCH] defconfig: arm64: add i.MX system controller thermal support
Message-ID: <1543298903-8389-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables CONFIG_IMX_SC_THERMAL by default.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	This patch is based on https://patchwork.kernel.org/patch/10677315/
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d3aa3f7..6d224f7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -376,6 +376,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_IMX_SC_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
-- 
2.7.4
