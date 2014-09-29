From: zhang.lyra@gmail.com (zhang.lyra at gmail.com)
Date: Mon, 29 Sep 2014 19:48:29 +0800
Subject: [PATCH 1/6] Documentation: DT: Add bindings for Spreadtrum serial
In-Reply-To: <1411991314-6636-1-git-send-email-zhang.lyra@gmail.com>
References: <1411991314-6636-1-git-send-email-zhang.lyra@gmail.com>
Message-ID: <1411991314-6636-2-git-send-email-zhang.lyra@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "chunyan.zhang" <chunyan.zhang@spreadtrum.com>

Adds the device-tree documentation for Spreadtrum's serial.

Signed-off-by: chunyan.zhang <chunyan.zhang@spreadtrum.com>
---
 .../devicetree/bindings/serial/of-serial.txt       |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
index 7705477..a0bb1d1 100644
--- a/Documentation/devicetree/bindings/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/serial/of-serial.txt
@@ -14,6 +14,7 @@ Required properties:
 	- "altr,16550-FIFO32"
 	- "altr,16550-FIFO64"
 	- "altr,16550-FIFO128"
+	- "sprd,serial"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
-- 
1.7.9.5
