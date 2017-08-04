From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Fri,  4 Aug 2017 16:06:12 +0800
Subject: [PATCH v2 1/5] dt-bindings: rockchip-thermal: Support the RK3328 SoC
 compatible
In-Reply-To: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1501833976-1100-2-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

attempt to new compatible for thermal founding on RK3328 SoC.

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
Change in v2:
- remove gerrit Change-Id

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index 43003aec94bd..e3a6234fb1ac 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible : should be "rockchip,<name>-tsadc"
    "rockchip,rk3228-tsadc": found on RK3228 SoCs
    "rockchip,rk3288-tsadc": found on RK3288 SoCs
+   "rockchip,rk3328-tsadc": found on RK3328 SoCs
    "rockchip,rk3368-tsadc": found on RK3368 SoCs
    "rockchip,rk3399-tsadc": found on RK3399 SoCs
 - reg : physical base address of the controller and length of memory mapped
-- 
1.9.1
