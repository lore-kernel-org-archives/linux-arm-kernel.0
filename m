From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Jun 2017 17:43:05 -0300
Subject: [PATCH 4/4] ARM: imx_v6_v7_defconfig: Enable GPIO_74X164
In-Reply-To: <1498855385-9690-1-git-send-email-festevam@gmail.com>
References: <1498855385-9690-1-git-send-email-festevam@gmail.com>
Message-ID: <1498855385-9690-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx7d-sabresd board uses a 74LV595PW SPI expander to drive several
peripherals, such as Ethernet reset, PCI reset, LCD power, etc.

Enabled this option by default.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index b043caf..bf51949 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -200,6 +200,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_STMPE=y
+CONFIG_GPIO_74X164=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_IMX=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.7.4
