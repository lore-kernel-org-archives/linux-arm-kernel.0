From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Dec 2016 23:46:20 +0100
Subject: [PATCH 4/4] ARM64: dts: marvell/armada-37xx: Correct license text
In-Reply-To: <20161214224620.23830-1-alexandre.belloni@free-electrons.com>
References: <20161214224620.23830-1-alexandre.belloni@free-electrons.com>
Message-ID: <20161214224620.23830-5-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The license test has been mangled at some point then copy pasted across
multiple files. Restore it to what it should be.
Note that this is not intended as a license change.

Cc: Andreas F?rber <afaerber@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e9bd58793464..3c6f5d9d15c4 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -15,17 +15,17 @@
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
@@ -34,11 +34,11 @@
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
