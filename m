From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:15:10 +0100
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: enable Vybrid OCOTP driver
In-Reply-To: <20180318201510.13086-1-stefan@agner.ch>
References: <20180318201510.13086-1-stefan@agner.ch>
Message-ID: <20180318201510.13086-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the OCOTP NVMEM driver for Vybrid (vf610) SoCs.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 67db78f8c9df..6ce94333be5c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -380,6 +380,7 @@ CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
 CONFIG_NVMEM_IMX_OCOTP=y
+CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_MUX_MMIO=y
-- 
2.16.2
