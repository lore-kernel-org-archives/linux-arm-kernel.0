From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:57 +0100
Subject: [PATCH 55/60] arm: dts: kirkwood-ts419-6282: use
 SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-56-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-ts419-6282.dts | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ts419-6282.dts b/arch/arm/boot/dts/kirkwood-ts419-6282.dts
index e3e71f48acc8..be772e194c2b 100644
--- a/arch/arm/boot/dts/kirkwood-ts419-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts419-6282.dts
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Device Tree file for QNAP TS41X with 6282 SoC
  *
  * Copyright (C) 2013, Andrew Lunn <andrew@lunn.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 /dts-v1/;
-- 
2.16.1
