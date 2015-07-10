From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 10 Jul 2015 14:04:04 +0800
Subject: [PATCH v2 1/6] Document: bindings: DT: Add SMP enable method for
 MT6580 SoC platform
In-Reply-To: <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <scott.shu@gmail.com>
 <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1436508249-49338-2-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MT6580 SoC platform, the secondary cores are in powered off state
as default, so compared with MT65xx series SoC, one new enable method
is needed. This method using the SPM (System Power Manager) inside
the SCPSYS to control the CPU power.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index be35054..eaee089 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -195,6 +195,7 @@ nodes to be present and contain the properties described below.
 			    "marvell,armada-380-smp"
 			    "marvell,armada-390-smp"
 			    "marvell,armada-xp-smp"
+			    "mediatek,mt6580-smp"
 			    "mediatek,mt65xx-smp"
 			    "mediatek,mt81xx-tz-smp"
 			    "qcom,gcc-msm8660"
-- 
1.8.1.1.dirty
