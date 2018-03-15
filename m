From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:11 +0100
Subject: [PATCH 09/60] arm: dts: kirkwood-d2net: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-10-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-d2net.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-d2net.dts b/arch/arm/boot/dts/kirkwood-d2net.dts
index e1c25c35e9ce..bd3b266dd766 100644
--- a/arch/arm/boot/dts/kirkwood-d2net.dts
+++ b/arch/arm/boot/dts/kirkwood-d2net.dts
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for d2 Network v2
  *
  * Copyright (C) 2014 Simon Guinot <simon.guinot@sequanux.org>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
 */
 
 /dts-v1/;
-- 
2.16.1
