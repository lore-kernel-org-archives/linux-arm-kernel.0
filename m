From: blogic@openwrt.org (John Crispin)
Date: Fri, 19 Feb 2016 09:44:05 +0100
Subject: [PATCH V6 01/11] dt-bindings: ARM: Mediatek: add MT2701/7623 string
 to the PMIC wrapper doc
In-Reply-To: <1455871455-21212-1-git-send-email-blogic@openwrt.org>
References: <1455871455-21212-1-git-send-email-blogic@openwrt.org>
Message-ID: <1455871455-21212-2-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: John Crispin <blogic@openwrt.org>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index ddeb5b6..107700d 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -18,6 +18,7 @@ IP Pairing
 
 Required properties in pwrap device node.
 - compatible:
+	"mediatek,mt2701-pwrap" for MT2701/7623 SoCs
 	"mediatek,mt8135-pwrap" for MT8135 SoCs
 	"mediatek,mt8173-pwrap" for MT8173 SoCs
 - interrupts: IRQ for pwrap in SOC
-- 
1.7.10.4
