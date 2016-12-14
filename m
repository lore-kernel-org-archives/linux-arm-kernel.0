From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Dec 2016 00:57:42 +0100
Subject: [PATCH 33/37] ARM: dts: vf610m4-cosmic: Correct license text
In-Reply-To: <20161214235746.7108-1-alexandre.belloni@free-electrons.com>
References: <20161214235746.7108-1-alexandre.belloni@free-electrons.com>
Message-ID: <20161214235746.7108-34-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The license test has been mangled at some point then copy pasted across
multiple files. Restore it to what it should be.
Note that this is not intended as a license change.

Cc: Afzal Mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/vf610m4-cosmic.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/vf610m4-cosmic.dts b/arch/arm/boot/dts/vf610m4-cosmic.dts
index 8944a2d2054c..f7474c11aabd 100644
--- a/arch/arm/boot/dts/vf610m4-cosmic.dts
+++ b/arch/arm/boot/dts/vf610m4-cosmic.dts
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
