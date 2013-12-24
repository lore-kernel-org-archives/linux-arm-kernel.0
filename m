From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Dec 2013 01:04:50 -0200
Subject: [PATCH v2 2/2] ARM: imx_v6_v7_defconfig: Select
 CONFIG_REGULATOR_PFUZE100
In-Reply-To: <1387854290-22497-1-git-send-email-festevam@gmail.com>
References: <1387854290-22497-1-git-send-email-festevam@gmail.com>
Message-ID: <1387854290-22497-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

PFUZE100 regulator is commonly found on mx6 based designs.

Add support for it. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 318c5fb..2c3245e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -167,6 +167,7 @@ CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
+CONFIG_REGULATOR_PFUZE100=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_RC_SUPPORT=y
-- 
1.8.1.2
