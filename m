From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:34 +0100
Subject: [PATCH 32/60] arm: dts: kirkwood-net5big: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-33-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-net5big.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-net5big.dts b/arch/arm/boot/dts/kirkwood-net5big.dts
index d2d44df9c8c0..cba8a2b6f6d9 100644
--- a/arch/arm/boot/dts/kirkwood-net5big.dts
+++ b/arch/arm/boot/dts/kirkwood-net5big.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for LaCie 5Big Network v2
  *
@@ -8,9 +9,6 @@
  * Based on netxbig_v2-setup.c,
  * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
 */
 
 /dts-v1/;
-- 
2.16.1
