From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 25 Nov 2018 18:02:45 -0200
Subject: [PATCH 2/2] ARM: dts: imx6: Switch NXP board dts to SPDX identifier
In-Reply-To: <1543176165-26733-1-git-send-email-festevam@gmail.com>
References: <1543176165-26733-1-git-send-email-festevam@gmail.com>
Message-ID: <1543176165-26733-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the SPDX license identifier headers to ease license compliance
management. 

Most of the i.MX NXP reference board dts files have already been
converted, so switch the remaining ones.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts   | 10 +++-----
 arch/arm/boot/dts/imx6sx-sdb-sai.dts    | 43 +++------------------------------
 arch/arm/boot/dts/imx6sx-sdb.dts        | 10 +++-----
 arch/arm/boot/dts/imx6sx-sdb.dtsi       | 10 +++-----
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi | 10 +++-----
 arch/arm/boot/dts/imx6ull-14x14-evk.dts | 43 +++------------------------------
 6 files changed, 18 insertions(+), 108 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index 9cc6ff2..9db9306 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -1,10 +1,6 @@
-/*
- * Copyright (C) 2015 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2015 Freescale Semiconductor, Inc.
 
 #include "imx6sx-sdb.dtsi"
 
diff --git a/arch/arm/boot/dts/imx6sx-sdb-sai.dts b/arch/arm/boot/dts/imx6sx-sdb-sai.dts
index 2ac865b..1c4eacd 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-sai.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-sai.dts
@@ -1,43 +1,6 @@
-/*
- * Copyright (C) 2016 NXP Semiconductors
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
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
- */
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (C) 2016 Freescale Semiconductor, Inc.
 
 #include "imx6sx-sdb.dts"
 
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 6dd9beb..96bd637 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -1,10 +1,6 @@
-/*
- * Copyright (C) 2015 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2015 Freescale Semiconductor, Inc.
 
 #include "imx6sx-sdb.dtsi"
 
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 7d7d679..51c3e33 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -1,10 +1,6 @@
-/*
- * Copyright (C) 2014 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 32a0723..9f06d54 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -1,10 +1,6 @@
-/*
- * Copyright (C) 2015 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2015 Freescale Semiconductor, Inc.
 
 / {
 	chosen {
diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
index 0ba6454..74aaa8a 100644
--- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
@@ -1,43 +1,6 @@
-/*
- * Copyright (C) 2016 Freescale Semiconductor, Inc.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
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
- */
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (C) 2016 Freescale Semiconductor, Inc.
 
 /dts-v1/;
 
-- 
2.7.4
