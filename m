From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 09:58:07 +0200
Subject: [PATCH 2/9] arm64: defconfig: enable Marvell CP110 comphy
In-Reply-To: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
Message-ID: <20170918075814.27405-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miquel Raynal <miquel.raynal@free-electrons.com>

The comphy is an hardware block giving access to common PHYs that can be
used by various other engines (Network, SATA, ...). This is used on
Marvell 7k/8k platforms for now. Enable the corresponding driver.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4c9d4f6692dc..8495b88a0966 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -535,6 +535,7 @@ CONFIG_PWM_TEGRA=m
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_PCIE=m
-- 
2.13.5
