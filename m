From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 11 Oct 2016 08:33:55 +0800
Subject: [PATCH 1/5] dt-bindings: add vendor prefix for ILI Technology Corp
Message-ID: <20161011003359.26079-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ILI Technology Corp (a.k.a Ilitek, http://www.ilitek.com/index-e.asp ) is a
company that produces LCD driver ICs and touch screen controller ICs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 24c6f65..4d37fdc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -130,6 +130,7 @@ i2se	I2SE GmbH
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
 ifi	Ingenieurburo Fur Ic-Technologie (I/F/I)
+ilitek	ILI Technologies Corp.
 img	Imagination Technologies Ltd.
 infineon Infineon Technologies
 inforce	Inforce Computing
-- 
2.10.1
