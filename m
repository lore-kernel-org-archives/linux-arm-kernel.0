From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 24 Sep 2015 23:38:57 +0800
Subject: [PATCH v4 2/5] devicetree: bindings: add new SMP enable method
 Mediatek SoC
In-Reply-To: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1443109140-5406-3-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit add new cpu enable method "mediatek,mt65xx-smp" and
"mediatek,mt81xx-tz-smp".

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 91e6e5c..3a07a87 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -195,6 +195,8 @@ nodes to be present and contain the properties described below.
 			    "marvell,armada-380-smp"
 			    "marvell,armada-390-smp"
 			    "marvell,armada-xp-smp"
+			    "mediatek,mt6589-smp"
+			    "mediatek,mt81xx-tz-smp"
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
-- 
1.9.1
