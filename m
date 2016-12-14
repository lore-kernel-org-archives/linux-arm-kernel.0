From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Dec 2016 23:37:44 +0100
Subject: [PATCH 37/39] ARM: dts: kirkwood-linkstation: Correct license text
In-Reply-To: <20161214223746.23066-1-alexandre.belloni@free-electrons.com>
References: <20161214223746.23066-1-alexandre.belloni@free-electrons.com>
Message-ID: <20161214223746.23066-38-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The license test has been mangled at some point then copy pasted across
multiple files. Restore it to what it should be.
Note that this is not intended as a license change.

Cc: Mario Lange <mario_lange@gmx.net>
Cc: Roger Shimizu <rogershimizu@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts      | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts    | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation.dtsi          | 10 +++++-----
 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi         | 10 +++++-----
 arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi | 10 +++++-----
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts       | 10 +++++-----
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts     | 10 +++++-----
 arch/arm/boot/dts/orion5x-linkstation.dtsi           | 10 +++++-----
 13 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi b/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
index 6548e68a20d0..b9125e5ed076 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi b/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
index cf2e69f0d54f..29d929535453 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
index 6dc0df2969f0..9cc05203baee 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
+++ b/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
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
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
index edcba5c44b05..ff37e76ab551 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
+++ b/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts
index 4b6450186af5..f602c059c718 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts
+++ b/arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
index 954ec1d5b6dc..ef8fc1a077f8 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
+++ b/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts
index ecd5c12a805d..ce41d553b693 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts
+++ b/arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/kirkwood-linkstation.dtsi b/arch/arm/boot/dts/kirkwood-linkstation.dtsi
index 36c54c9dfa30..b459042a904a 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation.dtsi
+++ b/arch/arm/boot/dts/kirkwood-linkstation.dtsi
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/mvebu-linkstation-fan.dtsi b/arch/arm/boot/dts/mvebu-linkstation-fan.dtsi
index e211a3c47a76..e172029a0c4d 100644
--- a/arch/arm/boot/dts/mvebu-linkstation-fan.dtsi
+++ b/arch/arm/boot/dts/mvebu-linkstation-fan.dtsi
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi b/arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi
index 68d75e79a360..c2d87ba6190a 100644
--- a/arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi
+++ b/arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
index 51dc734cd5b9..9f6fedd39170 100644
--- a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
@@ -18,17 +18,17 @@
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
@@ -37,11 +37,11 @@
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
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
index 0eead400f427..7f77ce8cc1fc 100644
--- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
diff --git a/arch/arm/boot/dts/orion5x-linkstation.dtsi b/arch/arm/boot/dts/orion5x-linkstation.dtsi
index ed456ab35fd8..e9991c83d7b7 100644
--- a/arch/arm/boot/dts/orion5x-linkstation.dtsi
+++ b/arch/arm/boot/dts/orion5x-linkstation.dtsi
@@ -14,17 +14,17 @@
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
@@ -33,11 +33,11 @@
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
