From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Nov 2015 00:00:54 +0100
Subject: [PATCH 1/2] ARM: mvebu: add kirkwood compatibles for cloudengine
 boards
Message-ID: <1448578854-6256-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the compatible strings for Cloudengine PogoPlug E02 and
series 4. The former already has a devicetree in the kernel.

Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/marvell,kirkwood.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
index 5171ad8f48ff..ab0c9cdf388e 100644
--- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
@@ -24,6 +24,8 @@ board. Currently known boards are:
 "buffalo,lswxl"
 "buffalo,lsxhl"
 "buffalo,lsxl"
+"cloudengines,pogo02"
+"cloudengines,pogoplugv4"
 "dlink,dns-320"
 "dlink,dns-320-a1"
 "dlink,dns-325"
-- 
2.4.3
