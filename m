From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:24 +0100
Subject: [PATCH 22/60] arm: dts: kirkwood-ds409: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-23-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Ben Peddell <klightspeed@killerwolves.net>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-ds409.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ds409.dts b/arch/arm/boot/dts/kirkwood-ds409.dts
index e80a962ebba0..a8650f9e3eb7 100644
--- a/arch/arm/boot/dts/kirkwood-ds409.dts
+++ b/arch/arm/boot/dts/kirkwood-ds409.dts
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Andrew Lunn <andrew@lunn.ch>
  * Ben Peddell <klightspeed@killerwolves.net>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /dts-v1/;
-- 
2.16.1
