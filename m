From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  1 Jul 2018 19:56:01 -0300
Subject: [PATCH] ARM: dts: imx6sll: Fix the SPDX notation for header file
Message-ID: <1530485761-5931-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Per Documentation/process/license-rules.rst the SPDX notation for
header file should be /* */ style, so fix it accordingly.

Fixes: 9f30b6b1a957 ("ARM: dts: imx: Add basic dtsi file for imx6sll")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sll-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll-pinfunc.h b/arch/arm/boot/dts/imx6sll-pinfunc.h
index b1c40dc..713a346 100644
--- a/arch/arm/boot/dts/imx6sll-pinfunc.h
+++ b/arch/arm/boot/dts/imx6sll-pinfunc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2016 Freescale Semiconductor, Inc.
  * Copyright 2017-2018 NXP.
-- 
2.7.4
