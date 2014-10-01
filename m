From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed,  1 Oct 2014 23:29:45 +0200
Subject: [PATCH 5/6] ARM: document Tronsmart compatible properties
In-Reply-To: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
References: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1412198986-26534-6-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document device tree bindings for Tronsmart devices.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/arm/tronsmart.txt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tronsmart.txt

diff --git a/Documentation/devicetree/bindings/arm/tronsmart.txt b/Documentation/devicetree/bindings/arm/tronsmart.txt
new file mode 100644
index 0000000..bd29d60
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tronsmart.txt
@@ -0,0 +1,7 @@
+Tronsmart Platforms Device Tree Bindings
+---------------------------------------
+
+Vega S89 Elite TV box
+
+Required root node properties:
+    - compatible = "tronsmart,vega-s89e";
-- 
1.9.1
