From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:14 +0200
Subject: [PATCH 09/14] Input: touchscreen: Broadcom iProc: DT spelling
 s/clock-name/clock-names/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-10-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
index 25541f30e38701f2..ac5dff412e25266f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
@@ -7,7 +7,7 @@ Required properties:
   If this property is selected please make sure MFD_SYSCON config
   is enabled in the defconfig file.
 - clocks:  The clock provided by the SOC to driver the tsc
-- clock-name:  name for the clock
+- clock-names:  name for the clock
 - interrupts: The touchscreen controller's interrupt
 - address-cells: Specify the number of u32 entries needed in child nodes.
   Should set to 1.
-- 
1.9.1
