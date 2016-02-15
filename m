From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 13:44:42 +0100
Subject: [PATCH -trivial] devicetree: bindings: ARM: Use "uV" for micro-volt
Message-ID: <1455540282-23619-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding documentation uses both "uVolt" and "uV" for micro-volt.
Improve consistency by settling on "uV".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index ae9be074d09f66d5..afcf50f050ad3f56 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -250,7 +250,7 @@ nodes to be present and contain the properties described below.
 		Usage: optional
 		Value type: <prop-encoded-array>
 		Definition: A u32 value that represents the running time dynamic
-			    power coefficient in units of mW/MHz/uVolt^2. The
+			    power coefficient in units of mW/MHz/uV^2. The
 			    coefficient can either be calculated from power
 			    measurements or derived by analysis.
 
-- 
1.9.1
