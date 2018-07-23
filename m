From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 14:06:21 +0200
Subject: [PATCH 3/8] ARM: dts: convert to SPDX identifier for Renesas boards
In-Reply-To: <cover.1532345886.git.horms+renesas@verge.net.au>
References: <cover.1532345886.git.horms+renesas@verge.net.au>
Message-ID: <cdbfaf640a23334a7bd2d8a8689051711a4e23c2.1532345886.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts                   | 5 +----
 arch/arm/boot/dts/emev2.dtsi                        | 5 +----
 arch/arm/boot/dts/iwg20d-q7-common.dtsi             | 5 +----
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi            | 5 +----
 arch/arm/boot/dts/r7s72100-genmai.dts               | 5 +----
 arch/arm/boot/dts/r7s72100-gr-peach.dts             | 5 +----
 arch/arm/boot/dts/r7s72100-rskrza1.dts              | 5 +----
 arch/arm/boot/dts/r7s72100.dtsi                     | 5 +----
 arch/arm/boot/dts/r8a73a4-ape6evm.dts               | 5 +----
 arch/arm/boot/dts/r8a73a4.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts       | 5 +----
 arch/arm/boot/dts/r8a7740.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts     | 5 +----
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts             | 5 +----
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi               | 5 +----
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts              | 5 +----
 arch/arm/boot/dts/r8a7743.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 5 +----
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts         | 5 +----
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi               | 5 +----
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts              | 5 +----
 arch/arm/boot/dts/r8a7745.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7778-bockw.dts                 | 5 +----
 arch/arm/boot/dts/r8a7778.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7779-marzen.dts                | 5 +----
 arch/arm/boot/dts/r8a7779.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7790-lager.dts                 | 5 +----
 arch/arm/boot/dts/r8a7790.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7791-koelsch.dts               | 5 +----
 arch/arm/boot/dts/r8a7791-porter.dts                | 5 +----
 arch/arm/boot/dts/r8a7791.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7792-blanche.dts               | 5 +----
 arch/arm/boot/dts/r8a7792-wheat.dts                 | 5 +----
 arch/arm/boot/dts/r8a7792.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7793-gose.dts                  | 5 +----
 arch/arm/boot/dts/r8a7793.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a7794-alt.dts                   | 5 +----
 arch/arm/boot/dts/r8a7794-silk.dts                  | 5 +----
 arch/arm/boot/dts/r8a7794.dtsi                      | 5 +----
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi      | 5 +----
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi      | 5 +----
 arch/arm/boot/dts/sh73a0-kzm9g.dts                  | 5 +----
 arch/arm/boot/dts/sh73a0.dtsi                       | 5 +----
 43 files changed, 43 insertions(+), 172 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 0af44b7eadb9..1bb8e5c9d029 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the KZM9D board
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index fec1241b858f..373ea8720769 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the EMEV2 SoC
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 66954aaf2c47..5cae74eb6cdd 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZ/G1M/G1N Qseven carrier board
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
index 476273b3f994..0e99df218252 100644
--- a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZ-G1M/N Daughter Board Camera Module
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 / {
diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 5af2a0116ff2..474baa0c7cfc 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Genmai board
  *
  * Copyright (C) 2013-14 Renesas Solutions Corp.
  * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index 779f724b4531..fe1a4aa4d7cb 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the GR-Peach board
  *
  * Copyright (C) 2017 Jacopo Mondi <jacopo+renesas@jmondi.org>
  * Copyright (C) 2016 Renesas Electronics
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index 5dcaaf131d27..8ee44a100e9a 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the RZ/A1H RSK board
  *
  * Copyright (C) 2016 Renesas Electronics
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index a54822e97bac..2211f88ede2a 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r7s72100 SoC
  *
  * Copyright (C) 2013-14 Renesas Solutions Corp.
  * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r7s72100-clock.h>
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 125c39c0222f..d530f451467e 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the APE6EVM board
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 080d037f5733..dd865f3c2eda 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a73a4 SoC
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
  * Copyright (C) 2013 Magnus Damm
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a73a4-clock.h>
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 03b00d87b39b..32757caa2584 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the armadillo 800 eva board
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index eb9a911deefb..383cba68dbba 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7740 SoC
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7740-clock.h>
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
index d90eb8464222..327545119ee3 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZ/G1M Qseven board + camera daughter board
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 6aa6b7467704..b683db4da8b1 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZ/G1M Qseven board
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index d364685d9184..0e2e033cc849 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZG1M-20M Qseven SOM
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "r8a7743.dtsi"
diff --git a/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts b/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
index 3d918d106593..ca0e0fc9b246 100644
--- a/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
+++ b/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the SK-RZG1M board
  *
  * Copyright (C) 2016-2017 Cogent Embedded, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index e4fb31c4f0ee..24715f74ae08 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7743 SoC
  *
  * Copyright (C) 2016-2017 Cogent Embedded Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
index d34de8266ccd..2aeebfc9e4f1 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZG1E SODIMM carrier board + HDMI daughter
  * board
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "r8a7745-iwg22d-sodimm.dts"
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index a4058f4cfbcd..1db220cfc1a1 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZG1E SODIMM carrier board
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
index 29b6e10fdf96..41f111b99a75 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the iWave-RZG1E-G22M SODIMM SOM
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "r8a7745.dtsi"
diff --git a/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts b/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
index b4d679b04ad6..655b10bb42d5 100644
--- a/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
+++ b/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the SK-RZG1E board
  *
  * Copyright (C) 2016-2017 Cogent Embedded, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 1cb7a7ab0418..c53f7ff20695 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7745 SoC
  *
  * Copyright (C) 2016-2017 Cogent Embedded Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index c79d55eb43c5..de808d2ea856 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Reference Device Tree Source for the Bock-W board
  *
@@ -8,10 +9,6 @@
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
  * Copyright (C) 2013 Simon Horman
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 3b49f9ed2e2b..1bce16cc6b20 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for Renesas r8a7778
  *
@@ -8,10 +9,6 @@
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
  * Copyright (C) 2013 Simon Horman
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7778-clock.h>
diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 4b9006bac3cb..a4d0038363f0 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Marzen board
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
  * Copyright (C) 2013 Simon Horman
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index e79ae306eedd..6b997bc016ee 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for Renesas r8a7779
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
  * Copyright (C) 2013 Simon Horman
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7779-clock.h>
diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 092610e3f953..50312e752e2f 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Lager board
  *
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded, Inc.
  * Copyright (C) 2015-2016 Renesas Electronics Corporation
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c4324b1a2ec4..0925bdca438f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7790 SoC
  *
  * Copyright (C) 2015 Renesas Electronics Corporation
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 8ab793d8b2fd..ce22db01fbba 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Koelsch board
  *
  * Copyright (C) 2013 Renesas Electronics Corporation
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 5f77d73d7462..f02036e5de01 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Porter board
  *
  * Copyright (C) 2015 Cogent Embedded, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d1d726a1364a..991ac6feedd5 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7791 SoC
  *
  * Copyright (C) 2013-2015 Renesas Electronics Corporation
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index 04fb70931b3b..f92301290b02 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Blanche board
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright (C) 2016 Cogent  Embedded, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7792-wheat.dts b/arch/arm/boot/dts/r8a7792-wheat.dts
index db01de7a3811..f46f4567b3d4 100644
--- a/arch/arm/boot/dts/r8a7792-wheat.dts
+++ b/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Wheat board
  *
  * Copyright (C) 2016 Renesas Electronics Corporation
  * Copyright (C) 2016 Cogent  Embedded, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index f44257dd86f6..63a978ec81cc 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7792 SoC
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7792-cpg-mssr.h>
diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index aa209f6e5d71..6b2f3a4fd13d 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Gose board
  *
  * Copyright (C) 2014-2015 Renesas Electronics Corporation
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 1e6439b85a6b..620a570307ff 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7793 SoC
  *
  * Copyright (C) 2014-2015 Renesas Electronics Corporation
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7793-cpg-mssr.h>
diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index e17027532941..ef7e2a837df6 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the Alt board
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 7808aaee6644..daec965889d3 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the SILK board
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright (C) 2014-2015 Renesas Solutions Corp.
  * Copyright (C) 2014-2015 Cogent Embedded, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 736196903d22..ea2ca4bdaf1c 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the r8a7794 SoC
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright (C) 2014 Ulrich Hecht
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/r8a7794-cpg-mssr.h>
diff --git a/arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi b/arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi
index 238d14bb0ebe..79fce67ebb1c 100644
--- a/arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi
+++ b/arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Common file for the AA104XD12 panel connected to Renesas R-Car boards
  *
  * Copyright (C) 2014 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 / {
diff --git a/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
index 04aafd479775..6e7589ea7562 100644
--- a/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
+++ b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Common file for the AA121TD01 panel connected to Renesas R-Car boards
  *
  * Copyright (C) 2015 Renesas Electronics Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 / {
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 3d65f1f6d78b..daac0c6078c5 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the KZM-A9-GT board
  *
@@ -5,10 +6,6 @@
  *
  * Based on sh73a0-kzm9g.dts
  * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index c953648a5f41..e8f0a07c4564 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for the SH73A0 SoC
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/clock/sh73a0-clock.h>
-- 
2.11.0
