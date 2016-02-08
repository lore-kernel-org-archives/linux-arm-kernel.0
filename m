From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  8 Feb 2016 18:07:53 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_CRYPTO_DEV_SAHARA
Message-ID: <1454962073-22401-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Select the sahara crypto driver that is used on i.MX53.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 25a6066..d218c27 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -367,6 +367,7 @@ CONFIG_PROVE_LOCKING=y
 # CONFIG_ARM_UNWIND is not set
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
+CONFIG_CRYPTO_DEV_SAHARA=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC7=m
-- 
1.9.1
