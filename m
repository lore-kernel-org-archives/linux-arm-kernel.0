From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 11:39:56 -0300
Subject: [PATCH 1/7] arm64: defconfig: Enable typec-phy and
 extcon-usbc-cros-ec for rk3399
In-Reply-To: <20180416144002.15569-1-ezequiel@collabora.com>
References: <20180416144002.15569-1-ezequiel@collabora.com>
Message-ID: <20180416144002.15569-2-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Enables typec phyter and extcon driver for cable detection that is used by
USB 3.0 controller for Rockchip rk3399 SoCs.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Alexandre Courbot <acourbot@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf613761e78..bdd594387232 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -568,6 +568,7 @@ CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
+CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_MEMORY=y
 CONFIG_TEGRA_MC=y
 CONFIG_IIO=y
@@ -590,6 +591,7 @@ CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_PCIE=m
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
-- 
2.16.3
