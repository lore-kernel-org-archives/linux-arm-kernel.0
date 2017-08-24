From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Thu, 24 Aug 2017 18:27:51 +0800
Subject: [PATCH 1/5] dt-bindings: rockchip-thermal: Support the RV1108 SoC
 compatible
In-Reply-To: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1503570475-7850-2-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible for thermal founding on RV1108 SoCs.

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index e3a6234fb1ac..43d744e5305e 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible : should be "rockchip,<name>-tsadc"
+   "rockchip,rv1108-tsadc": found on RV1108 SoCs
    "rockchip,rk3228-tsadc": found on RK3228 SoCs
    "rockchip,rk3288-tsadc": found on RK3288 SoCs
    "rockchip,rk3328-tsadc": found on RK3328 SoCs
-- 
1.9.1
