From: scott.shu@mediatek.com (Scott Shu)
Date: Sun, 23 Aug 2015 17:01:01 +0800
Subject: [PATCH v4 2/8] dt-bindings: soc: Add SCPSYS compatible support for
 mt6580
In-Reply-To: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
References: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1440320467-26118-3-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds "mediatek,mt6580-scpsys" in the compatible properties of
SCPSYS node for MT6580 SoC.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index c051114..7998bc2 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -12,7 +12,7 @@ power/power_domain.txt. It provides the power domains defined in
 include/dt-bindings/power/mt8173-power.h.
 
 Required properties:
-- compatible: Must be "mediatek,mt8173-scpsys"
+- compatible: Must be "mediatek,mt6580-scpsys" or "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
 - infracfg: must contain a phandle to the infracfg controller
-- 
1.9.1

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
