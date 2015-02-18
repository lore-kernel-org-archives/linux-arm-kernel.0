From: fkan@apm.com (Feng Kan)
Date: Wed, 18 Feb 2015 11:34:02 -0800
Subject: [PATCH V2 2/3] Documentation: i2c: Add APM X-Gene platform SLIMpro
 I2C driver documentation
In-Reply-To: <1424288043-2995-1-git-send-email-fkan@apm.com>
References: <1424288043-2995-1-git-send-email-fkan@apm.com>
Message-ID: <1424288043-2995-2-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene platform SLIMpro I2C driver documentation.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Hieu Le <hnle@apm.com>
---
 .../devicetree/bindings/i2c/i2c-xgene-slimpro.txt         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt b/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
new file mode 100644
index 0000000..f6b2c20
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
@@ -0,0 +1,15 @@
+APM X-Gene SLIMpro Mailbox I2C Driver
+
+An I2C controller accessed over the "SLIMpro" mailbox.
+
+Required properties :
+
+ - compatible : should be "apm,xgene-slimpro-i2c"
+ - mboxes : use the label reference for the mailbox as the first parameter.
+	    The second parameter is the channel number.
+
+Example :
+	i2cslimpro {
+		compatible = "apm,xgene-slimpro-i2c";
+		mboxes = <&mailbox 0>;
+	};
-- 
1.9.1
