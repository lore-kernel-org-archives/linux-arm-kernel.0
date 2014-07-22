From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 15:52:29 +0100
Subject: [PATCH 2/5] power: reset: st: Provide DT bindings for ST's Power
 Reset driver
In-Reply-To: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
References: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406040752-25229-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/st-reset.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/st-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/st-reset.txt b/Documentation/devicetree/bindings/power/reset/st-reset.txt
new file mode 100644
index 0000000..809af54
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/st-reset.txt
@@ -0,0 +1,11 @@
+*Device-Tree bindings for ST SW reset functionality
+
+Required properties:
+- compatible: should be "st,<chip>-restart".
+- st,syscfg: should be a phandle of the syscfg node.
+
+Example node:
+	restart {
+		compatible = "st,stih416-restart";
+		st,syscfg = <&syscfg_sbc>;
+	};
-- 
1.8.3.2
