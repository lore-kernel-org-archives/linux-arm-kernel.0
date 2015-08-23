From: scott.shu@mediatek.com (Scott Shu)
Date: Sun, 23 Aug 2015 17:01:00 +0800
Subject: [PATCH v4 1/8] Document: bindings: DT: Add SMP enable method for
 MT6580 SoC platform
In-Reply-To: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
References: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1440320467-26118-2-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MT6580 SoC platform, the secondary cores are in powered off state
as default, so compared with MT6589, one new enable method is needed.
This method using the SPM (System Power Manager) inside the SCPSYS to
control the CPU power.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index d58eb45..66a8f03 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -195,6 +195,7 @@ nodes to be present and contain the properties described below.
 			    "marvell,armada-380-smp"
 			    "marvell,armada-390-smp"
 			    "marvell,armada-xp-smp"
+			    "mediatek,mt6580-smp"
 			    "mediatek,mt6589-smp"
 			    "mediatek,mt81xx-tz-smp"
 			    "qcom,gcc-msm8660"
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
