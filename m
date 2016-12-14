From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Dec 2016 23:37:19 +0100
Subject: [PATCH 12/39] ARM: dts: armada-38x: Correct license text
In-Reply-To: <20161214223746.23066-1-alexandre.belloni@free-electrons.com>
References: <20161214223746.23066-1-alexandre.belloni@free-electrons.com>
Message-ID: <20161214223746.23066-13-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The license test has been mangled at some point then copy pasted across
multiple files. Restore it to what it should be.
Note that this is not intended as a license change.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi | 10 +++++-----
 arch/arm/boot/dts/armada-385.dtsi | 10 +++++-----
 arch/arm/boot/dts/armada-38x.dtsi | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 5102d19cc8f4..e392f6036f39 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -17,17 +17,17 @@
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This file is distributed in the hope that it will be useful
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- * Or, alternatively
+ * Or, alternatively,
  *
  *  b) Permission is hereby granted, free of charge, to any person
  *     obtaining a copy of this software and associated documentation
  *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use
+ *     restriction, including without limitation the rights to use,
  *     copy, modify, merge, publish, distribute, sublicense, and/or
  *     sell copies of the Software, and to permit persons to whom the
  *     Software is furnished to do so, subject to the following
@@ -36,11 +36,11 @@
  *     The above copyright notice and this permission notice shall be
  *     included in all copies or substantial portions of the Software.
  *
- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 8e67d2c083dd..8e63be33472e 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -17,17 +17,17 @@
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This file is distributed in the hope that it will be useful
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- * Or, alternatively
+ * Or, alternatively,
  *
  *  b) Permission is hereby granted, free of charge, to any person
  *     obtaining a copy of this software and associated documentation
  *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use
+ *     restriction, including without limitation the rights to use,
  *     copy, modify, merge, publish, distribute, sublicense, and/or
  *     sell copies of the Software, and to permit persons to whom the
  *     Software is furnished to do so, subject to the following
@@ -36,11 +36,11 @@
  *     The above copyright notice and this permission notice shall be
  *     included in all copies or substantial portions of the Software.
  *
- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 2d7668848c5a..85727b21c6c9 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -17,17 +17,17 @@
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This file is distributed in the hope that it will be useful
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- * Or, alternatively
+ * Or, alternatively,
  *
  *  b) Permission is hereby granted, free of charge, to any person
  *     obtaining a copy of this software and associated documentation
  *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use
+ *     restriction, including without limitation the rights to use,
  *     copy, modify, merge, publish, distribute, sublicense, and/or
  *     sell copies of the Software, and to permit persons to whom the
  *     Software is furnished to do so, subject to the following
@@ -36,11 +36,11 @@
  *     The above copyright notice and this permission notice shall be
  *     included in all copies or substantial portions of the Software.
  *
- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
-- 
2.10.2
