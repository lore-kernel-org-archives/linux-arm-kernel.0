From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 03:10:05 +0200
Subject: [PATCH v6 01/12] ARM: shmobile: r7s72100: document MSTP clock support
In-Reply-To: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400029816-24028-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 02a25d99ca61..6c3c0847e4fd 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -10,6 +10,7 @@ index in the group, from 0 to 31.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
     - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
-- 
1.9.2
