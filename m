From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 18 Feb 2015 15:07:48 -0500
Subject: [PATCH 1/2] Documentation: bindings: add optional fifo size property
 to AMBA UARTs
In-Reply-To: <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <amba uarts - arm type uarts fifo size provided by device tree>
 <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <1424290069-8760-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 Documentation/devicetree/bindings/serial/pl011.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
index 5d2e840..05d1adb 100644
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ b/Documentation/devicetree/bindings/serial/pl011.txt
@@ -13,5 +13,6 @@ Optional properties:
 - dmas:	   When present, may have one or two dma channels.
 	   The first one must be named "rx", the second one
 	   must be named "tx".
+- fifo-size:  When present, must have the fifo size.
 
 See also bindings/arm/primecell.txt
-- 
1.9.1
