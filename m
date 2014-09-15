From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Sep 2014 16:44:59 +0200
Subject: [PATCH 2/6] ARM: meson: documentation: add bindings documentation
In-Reply-To: <1410792303-23275-1-git-send-email-carlo@caione.org>
References: <1410792303-23275-1-git-send-email-carlo@caione.org>
Message-ID: <1410792303-23275-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vendor prefixes and basic documentation for MesonX SoCs bindings

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt     | 8 ++++++++
 Documentation/devicetree/bindings/arm/geniatech.txt   | 5 +++++
 Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
 3 files changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
new file mode 100644
index 0000000..7eece72
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -0,0 +1,8 @@
+Amlogic MesonX device tree bindings
+-------------------------------------------
+
+Boards with the Amlogic Meson6 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "amlogic,meson6";
diff --git a/Documentation/devicetree/bindings/arm/geniatech.txt b/Documentation/devicetree/bindings/arm/geniatech.txt
new file mode 100644
index 0000000..74ccba4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/geniatech.txt
@@ -0,0 +1,5 @@
+Geniatech platforms device tree bindings
+-------------------------------------------
+
+Geniatech ATV1200
+    - compatible = "geniatech,atv1200"
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..17078cb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -14,6 +14,7 @@ allwinner	Allwinner Technology Co., Ltd.
 altr	Altera Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
+amlogic	Amlogic, Inc.
 ams	AMS AG
 amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
@@ -52,6 +53,7 @@ excito	Excito
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+geniatech	Geniatech, Inc.
 globalscale	Globalscale Technologies, Inc.
 gmt	Global Mixed-mode Technology, Inc.
 google	Google, Inc.
-- 
1.9.1
