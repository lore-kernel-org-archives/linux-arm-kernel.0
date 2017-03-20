From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 20 Mar 2017 14:47:25 +0800
Subject: [PATCH v6 2/4] dt-bindings: mfd: Add the description for LED as the
 sub module
In-Reply-To: <1489992447-13007-1-git-send-email-sean.wang@mediatek.com>
References: <1489992447-13007-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1489992447-13007-3-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patch adds description for LED as the sub-module on MT6397/MT6323
multifunction device.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index c568d52..522a3bb 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -6,6 +6,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
 - Audio codec
 - GPIO
 - Clock
+- LED
 
 It is interfaced to host controller using SPI interface by a proprietary hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
-- 
1.9.1
