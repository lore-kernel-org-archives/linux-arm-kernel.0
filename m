From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:58 +0100
Subject: [PATCH 56/60] arm: dts: kirkwood-ts419: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-57-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-ts419.dtsi | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ts419.dtsi b/arch/arm/boot/dts/kirkwood-ts419.dtsi
index 02bd53762705..717236853e45 100644
--- a/arch/arm/boot/dts/kirkwood-ts419.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts419.dtsi
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Device Tree include file for QNAP TS41X
  *
  * Copyright (C) 2013, Andrew Lunn <andrew@lunn.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 / {
-- 
2.16.1
