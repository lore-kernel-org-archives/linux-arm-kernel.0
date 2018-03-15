From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 16:07:13 +0100
Subject: [PATCH 32/36] arm: dts: armada-388-gp: use SPDX-License-Identifier
In-Reply-To: <20180315150717.10588-1-gregory.clement@bootlin.com>
References: <20180315150717.10588-1-gregory.clement@bootlin.com>
Message-ID: <20180315150717.10588-33-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description, and also fix the
wrongly stated X11 to MIT.

As already pointed on the DT ML, the X11 license text [1] is explicitly
for the X Consortium and has a couple of extra clauses. The MIT
license text [2] is actually what the current DT files claim.

[1] https://spdx.org/licenses/X11.html
[2] https://spdx.org/licenses/MIT.html

Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 51b4ee6df130..9d873257ac45 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree file for Marvell Armada 385 development board
  * (RD-88F6820-GP)
@@ -5,38 +6,6 @@
  * Copyright (C) 2014 Marvell
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2.  This program is licensed "as is" without
- *     any warranty of any kind, whether express or implied.
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
  */
 
 /dts-v1/;
-- 
2.16.1
