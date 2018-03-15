From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:45 +0100
Subject: [PATCH 43/60] arm: dts: kirkwood-rd88f6281: use
 SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-44-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
index 91f5da5dae5f..0f22f0e6f56b 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell RD88F6181 Common Board descrition
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This file contains the definitions that are common between the two
  * variants of the Marvell Kirkwood Development Board.
  */
-- 
2.16.1
