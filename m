From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Tue, 7 Jun 2016 19:14:18 +0200
Subject: [PATCH v3 4/4] ARM: dts: imx6q-cm-fx6: Relicense under GPLv2/X11
In-Reply-To: <20160607171418.1703-1-christopher.spinrath@rwth-aachen.de>
References: <20160607171418.1703-1-christopher.spinrath@rwth-aachen.de>
Message-ID: <ea2bc74063964d7b91bfebf9d9a5d5e0@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

GPLv2-only devicetrees make reuse difficult for software components
licensed under a different license. In particular, the Utilite Pro
devicetree file (which includes imx6q-cm-fx6.dts) is already dual
licensed under GPLv2/X11.

Hence, relicense imx6q-cm-fx6.dts under GPLv2/X11 dual license.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---

Notes:
    Changes since v2:
     - fix typo in commit message
     - add Igor's Acked-By (replacing the Cc)
    
    Changes since v1:
     - new patch in v2; without it the dual licensed of the imx6q-utilite-pro.dts
       is not really useful because it includes imx6q-cm-fx6.dts.

 arch/arm/boot/dts/imx6q-cm-fx6.dts | 40 +++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 1ec3186..6d8d5e9 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -3,12 +3,42 @@
  *
  * Author: Valentin Raevsky <valentin@compulab.co.il>
  *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
  *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
-- 
2.8.3
