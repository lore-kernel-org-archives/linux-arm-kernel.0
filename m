From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:44 +0100
Subject: [PATCH 42/60] arm: dts: kirkwood-rd88f6281-z0: use
 SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-43-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
index 6a4a65ec7944..a9fee2c2bcaf 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell RD88F6181 Z0 stepping descrition
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This file contains the definitions for the board using the Z0
  * stepping of the SoC. The ethernet switch has a "wan" port.
 */
-- 
2.16.1
