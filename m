From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 22 Dec 2016 04:02:33 +0800
Subject: [PATCH 1/3] dt-bindings: add vendor prefix for Lichee Pi
Message-ID: <20161221200235.11617-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lichee Pi is a new "Pi"-named development board series.

Currently available device, Lichee Pi One, is by only one person as
night job, so the device series name is chosen to be the vendor prefix.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e7f5d1..4ec84b7a3c56 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -161,6 +161,7 @@ lacie	LaCie
 lantiq	Lantiq Semiconductor
 lenovo	Lenovo Group Ltd.
 lg	LG Corporation
+licheepi	Lichee Pi
 linux	Linux-specific binding
 lltc	Linear Technology Corporation
 lsi	LSI Corp. (LSI Logic)
-- 
2.11.0
