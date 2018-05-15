From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 15:54:57 +0200
Subject: [PATCH v2 4/4] arm64: defconfig: enable Rockchip Innosilicon hdmiphy
In-Reply-To: <20180515135457.6252-1-heiko@sntech.de>
References: <20180515135457.6252-1-heiko@sntech.de>
Message-ID: <20180515135457.6252-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228 and rk3328 socs use an MMIO-connected hdmi-phy from Innosilicon.
So enable the necessary driver as module.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 74abf140e332..dff3de45cc04 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -604,6 +604,7 @@ CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_EMMC=y
+CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
 CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PHY_XGENE=y
-- 
2.17.0
