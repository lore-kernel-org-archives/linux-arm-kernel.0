From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 26 Dec 2014 16:26:54 +0800
Subject: [PATCH v3 1/4] Document: DT: Add bindings for mediatek MT8173 Soc
 Platform
In-Reply-To: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
References: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1419582417-4448-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devicetree binding document for mediatek MT8173 SoC.
This is a 64-bit four core Soc.
And mt8173-evb is a evaluation board based on mt8173.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 3be4013..dd7550a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -9,6 +9,7 @@ compatible: Must contain one of
    "mediatek,mt6592"
    "mediatek,mt8127"
    "mediatek,mt8135"
+   "mediatek,mt8173"
 
 
 Supported boards:
@@ -25,3 +26,6 @@ Supported boards:
 - MTK mt8135 tablet EVB:
     Required root node properties:
       - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
+- MTK mt8173 tablet EVB:
+    Required root node properties:
+      - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
-- 
1.8.1.1

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
