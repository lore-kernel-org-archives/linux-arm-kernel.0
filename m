From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 19 May 2017 13:45:40 +0530
Subject: [PATCH 40/41] ARM: multi_v7_defconfig: Enable PINCTRL_TI_IODELAY
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Message-ID: <20170519081541.26753-41-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PINCTRL_TI_IODELAY since it is required for MMC module in
DRA7 family of processors to configure "IODelay" values
depending on the enumerated MMC modes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2685e03600b1..9fc8cafe88f5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -412,6 +412,7 @@ CONFIG_PINCTRL_MSM8X74=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
+CONFIG_PINCTRL_TI_IODELAY=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
-- 
2.11.0
