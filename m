From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:32 +0100
Subject: [PATCH 30/60] arm: dts: kirkwood-nas2big: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-31-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-nas2big.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nas2big.dts b/arch/arm/boot/dts/kirkwood-nas2big.dts
index f53bcacf6b63..6a2934b7d0ce 100644
--- a/arch/arm/boot/dts/kirkwood-nas2big.dts
+++ b/arch/arm/boot/dts/kirkwood-nas2big.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for LaCie 2Big NAS
  *
@@ -5,9 +6,6 @@
  *
  * Author: Simon Guinot <simon.guinot@sequanux.org>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
 */
 
 /dts-v1/;
-- 
2.16.1
