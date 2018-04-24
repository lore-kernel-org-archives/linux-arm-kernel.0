From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:47 +0200
Subject: [PATCH 07/11] dt-bindings: add bindings for early devices
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-8-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a simple document describing the "earlydev" compatible fallback.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/early.txt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/early.txt

diff --git a/Documentation/devicetree/bindings/early.txt b/Documentation/devicetree/bindings/early.txt
new file mode 100644
index 000000000000..51cbd8630255
--- /dev/null
+++ b/Documentation/devicetree/bindings/early.txt
@@ -0,0 +1,7 @@
+* Early device driver
+
+Certain devices must be initialized early in the boot process. An early
+device node represents such a system component.
+
+Required properties:
+- compatible: Must contain the following fallback: "earlydev"
-- 
2.17.0
