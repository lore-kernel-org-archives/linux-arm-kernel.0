From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:42 +0100
Subject: [PATCH 40/60] arm: dts: kirkwood-rd88f6192: use
 SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-41-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-rd88f6192.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-rd88f6192.dts b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
index b8af907249fb..712d6042b132 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6192.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell RD88F6192 Board descrition
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This file contains the definitions that are common between the three
  * variants of the Marvell Kirkwood Development Board.
  */
-- 
2.16.1
