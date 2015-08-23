From: scott.shu@mediatek.com (Scott Shu)
Date: Sun, 23 Aug 2015 17:01:06 +0800
Subject: [PATCH v4 7/8] ARM: dts: mt6580: Add device nodes to the MT6580 dtsi
 file
In-Reply-To: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
References: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1440320467-26118-8-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SCPSYS device node to the MT6580 dtsi file.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/boot/dts/mt6580.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index 06fdf6c..40957d3 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -67,6 +67,12 @@
 		#clock-cells = <0>;
 	};
 
+	scpsys: scpsys at 10006000 {
+		#power-domain-cells = <1>;
+		compatible = "mediatek,mt6580-scpsys";
+		reg = <0x10006000 0x1000>;
+	};
+
 	timer: timer at 10008000 {
 		compatible = "mediatek,mt6580-timer",
 			     "mediatek,mt6577-timer";
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
