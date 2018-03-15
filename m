From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:50 +0100
Subject: [PATCH 48/60] arm: dts: kirkwood-t5325: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-49-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-t5325.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index 3500f4738fb0..fe63b3a03a72 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for HP t5325 Thin Client"
  *
@@ -6,9 +7,6 @@
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
 */
 
 /dts-v1/;
-- 
2.16.1
