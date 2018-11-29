From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Nov 2018 09:18:14 -0200
Subject: [PATCH 2/2] ARM: dts: imx53: Switch to SPDX identifier
In-Reply-To: <1543490294-5847-1-git-send-email-festevam@gmail.com>
References: <1543490294-5847-1-git-send-email-festevam@gmail.com>
Message-ID: <1543490294-5847-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the SPDX license identifier headers to ease license compliance
management. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx53.dtsi | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 930e2e1..a9804c0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -1,14 +1,7 @@
-/*
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
+// Copyright 2011 Freescale Semiconductor, Inc.
+// Copyright 2011 Linaro Ltd.
 
 #include "imx53-pinfunc.h"
 #include <dt-bindings/clock/imx5-clock.h>
-- 
2.7.4
