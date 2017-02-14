From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 14 Feb 2017 17:19:10 +0800
Subject: [PATCH 3/5] devicetree: bindings: revise compatible string of sprd
 uart
In-Reply-To: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1487063952-7113-4-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch revise the compatible string of sprd uart to "sc-uart"
since this driver is not only for SC9836, but for all Spreadtrum
SoCs so far.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index 2aff0f2..9b0ad52 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -1,7 +1,7 @@
 * Spreadtrum serial UART
 
 Required properties:
-- compatible: must be "sprd,sc9836-uart"
+- compatible: must be "sprd,sc-uart"
 - reg: offset and length of the register set for the device
 - interrupts: exactly one interrupt specifier
 - clocks: phandles to input clocks.
-- 
2.7.4
