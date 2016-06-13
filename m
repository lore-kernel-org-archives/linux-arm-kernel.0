From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 13 Jun 2016 22:37:05 +0200
Subject: [PATCH 2/3] dt-bindings: Add "allwinner,
 sun6i-a31-mmc" in documentation Documentation.
In-Reply-To: <1465850226-37420-1-git-send-email-manu@freebsd.org>
References: <1465850226-37420-1-git-send-email-manu@freebsd.org>
Message-ID: <1465850226-37420-3-git-send-email-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 4bf41d8..e60b24e 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -8,7 +8,8 @@ as the speed of SD standard 3.0.
 Absolute maximum transfer rate is 200MB/s
 
 Required properties:
- - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
+ - compatible : "allwinner,sun4i-a10-mmc", "allwinner,sun5i-a13-mmc" or
+   "allwinner,sun6i-a31-mmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
-- 
2.8.1
