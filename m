From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 21:54:17 +0800
Subject: [PATCH v3 1/8] Document: bindings: DT: Add SMP enable method for
 MT6580 SoC platform
In-Reply-To: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1438696464-59858-2-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MT6580 SoC platform, the secondary cores are in powered off state
as default, so compared with MT6589, one new enable method is needed.
This method using the SPM (System Power Manager) inside the SCPSYS to
control the CPU power.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt |    1 +
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
1.7.9.5
