From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Wed, 26 Jul 2017 14:05:31 +0200
Subject: [PATCH v5 1/4] dt-bindings: arm: Add entry for Beckhoff CX9020
In-Reply-To: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
References: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170726120534.5516-2-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

- add vendor prefix bhf for Beckhoff
- add new board binding bhf,cx9020

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
---
 Documentation/devicetree/bindings/arm/bhf.txt         | 6 ++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 MAINTAINERS                                           | 5 +++++
 3 files changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bhf.txt

diff --git a/Documentation/devicetree/bindings/arm/bhf.txt b/Documentation/devicetree/bindings/arm/bhf.txt
new file mode 100644
index 000000000000..886b503caf9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bhf.txt
@@ -0,0 +1,6 @@
+Beckhoff Automation Platforms Device Tree Bindings
+--------------------------------------------------
+
+CX9020 Embedded PC
+Required root node properties:
+    - compatible = "bhf,cx9020", "fsl,imx53";
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index daf465bef758..20c2cf57ebc9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -47,6 +47,7 @@ avic	Shanghai AVIC Optoelectronics Co., Ltd.
 axentia	Axentia Technologies AB
 axis	Axis Communications AB
 bananapi BIPAI KEJI LIMITED
+bhf	Beckhoff Automation GmbH & Co. KG
 boe	BOE Technology Group Co., Ltd.
 bosch	Bosch Sensortec GmbH
 boundary	Boundary Devices Inc.
diff --git a/MAINTAINERS b/MAINTAINERS
index f66488dfdbc9..e1d3111aea97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1196,6 +1196,11 @@ F:	arch/arm/boot/dts/sama*.dtsi
 F:	arch/arm/include/debug/at91.S
 F:	drivers/memory/atmel*
 
+ARM/BECKHOFF SUPPORT
+M:	Patrick Bruenn <p.bruenn@beckhoff.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/bhf.txt
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.11.0
