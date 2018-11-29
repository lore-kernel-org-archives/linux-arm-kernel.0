From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Nov 2018 09:18:13 -0200
Subject: [PATCH 1/2] ARM: dts: imx50: Switch to SPDX identifier
Message-ID: <1543490294-5847-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the SPDX license identifier headers to ease license compliance
management. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx50.dtsi | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 8be4ff4..ee1e3e8 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -1,15 +1,8 @@
-/*
- * Copyright 2013 Greg Ungerer <gerg@uclinux.org>
- * Copyright 2011 Freescale Semiconductor, Inc.
- * Copyright 2011 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2013 Greg Ungerer <gerg@uclinux.org>
+// Copyright 2011 Freescale Semiconductor, Inc.
+// Copyright 2011 Linaro Ltd.
 
 #include "imx50-pinfunc.h"
 #include <dt-bindings/gpio/gpio.h>
-- 
2.7.4
