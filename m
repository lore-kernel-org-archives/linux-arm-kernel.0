From: carlo@caione.org (Carlo Caione)
Date: Tue, 14 Oct 2014 20:35:49 +0200
Subject: [PATCH v2 3/3] ARM: meson: docs: Add docs for MesonX reset controller
In-Reply-To: <1413311749-13948-1-git-send-email-carlo@caione.org>
References: <1413311749-13948-1-git-send-email-carlo@caione.org>
Message-ID: <1413311749-13948-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 .../bindings/reset/amlogic,meson6-rst-mgr-ao.txt           | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson6-rst-mgr-ao.txt

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson6-rst-mgr-ao.txt b/Documentation/devicetree/bindings/reset/amlogic,meson6-rst-mgr-ao.txt
new file mode 100644
index 0000000..4a8fd41
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson6-rst-mgr-ao.txt
@@ -0,0 +1,14 @@
+Amlogic MesonX Reset Manager (AO domain)
+
+Required properties:
+- compatible : "amlogic,meson6-rst-mgr-ao"
+- reg : Should contain 1 register ranges(address and length)
+- #reset-cells: 1
+
+Example:
+
+	reset: reset at c8100040 {
+		#reset-cells = <1>;
+		compatible = "amlogic,meson6-rst-mgr-ao";
+		reg = <0xc8100040 0x4>;
+	};
-- 
1.9.1
