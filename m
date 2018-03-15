From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:54 +0100
Subject: [PATCH 52/60] arm: dts: kirkwood-nsa320: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-53-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Adam Baker <linux@baker-net.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-nsa320.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
index 6ab104b4bb42..b69b096f267b 100644
--- a/arch/arm/boot/dts/kirkwood-nsa320.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Device tree file for the Zyxel NSA 320 NAS box.
  *
  * Copyright (c) 2014, Adam Baker <linux@baker-net.org.uk>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  *
  * Based upon the board setup file created by Peter Schildmann */
 
-- 
2.16.1
