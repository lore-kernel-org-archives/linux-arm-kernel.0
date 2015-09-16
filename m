From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 16 Sep 2015 09:42:58 +0200
Subject: [PATCH 1/2] dt-bindings: Fix tipo in st,clkgen-pll documentation
In-Reply-To: <1442389379-9298-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1442389379-9298-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1442389379-9298-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

replace "sst,plls-c32-cx_x" by "st,plls-c32-cx_x"

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
index d8b168e..e2c6db0 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
@@ -21,8 +21,8 @@ Required properties:
 	"st,stih416-plls-c32-ddr",	"st,clkgen-plls-c32"
 	"st,stih407-plls-c32-a0",	"st,clkgen-plls-c32"
 	"st,stih407-plls-c32-a9",	"st,clkgen-plls-c32"
-	"sst,plls-c32-cx_0",		"st,clkgen-plls-c32"
-	"sst,plls-c32-cx_1",		"st,clkgen-plls-c32"
+	"st,plls-c32-cx_0",		"st,clkgen-plls-c32"
+	"st,plls-c32-cx_1",		"st,clkgen-plls-c32"
 
 	"st,stih415-gpu-pll-c32",	"st,clkgengpu-pll-c32"
 	"st,stih416-gpu-pll-c32",	"st,clkgengpu-pll-c32"
-- 
1.9.1
