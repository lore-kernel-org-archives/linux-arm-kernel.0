From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 16:07:00 +0100
Subject: [PATCH 19/36] arm: dts: armada-xp-db-xc3-24g4xg: use
 SPDX-License-Identifier
In-Reply-To: <20180315150717.10588-1-gregory.clement@bootlin.com>
References: <20180315150717.10588-1-gregory.clement@bootlin.com>
Message-ID: <20180315150717.10588-20-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description, and also fix the
wrongly stated X11 to MIT.

As already pointed on the DT ML, the X11 license text [1] is explicitly
for the X Consortium and has a couple of extra clauses. The MIT
license text [2] is actually what the current DT files claim.

[1] https://spdx.org/licenses/X11.html
[2] https://spdx.org/licenses/MIT.html

Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 39 +--------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index 06fce35d7491..a0ebb52683f1 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Device Tree file for DB-XC3-24G4XG board
  *
@@ -5,44 +6,6 @@
  *
  * Based on armada-xp-db.dts
  *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- *
  * Note: this Device Tree assumes that the bootloader has remapped the
  * internal registers to 0xf1000000 (instead of the default
  * 0xd0000000). The 0xf1000000 is the default used by the recent,
-- 
2.16.1
