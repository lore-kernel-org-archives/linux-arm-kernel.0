From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 11:28:43 +0200
Subject: [PATCH v3 4/4] arm64: defconfig: enable Rockchip Innosilicon hdmiphy
In-Reply-To: <20180910092843.1700-1-heiko@sntech.de>
References: <20180910092843.1700-1-heiko@sntech.de>
Message-ID: <20180910092843.1700-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228 and rk3328 socs use an MMIO-connected hdmi-phy from Innosilicon.
So enable the necessary driver as module.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364f8476..36ef2dcfa085 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -638,6 +638,7 @@ CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_RCAR_GEN3_USB3=m
 CONFIG_PHY_ROCKCHIP_EMMC=y
+CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_ROCKCHIP_TYPEC=y
-- 
2.17.0
