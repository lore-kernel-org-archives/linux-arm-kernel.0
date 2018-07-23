From: cl@rock-chips.com (cl at rock-chips.com)
Date: Mon, 23 Jul 2018 17:25:22 +0800
Subject: [PATCH v2 4/6] dt-bindings: rockchip: grf: add grf and pmugrf
 description for px30
In-Reply-To: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
Message-ID: <1532337924-4185-5-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

This patch adds the compatible of GRF and PMUGRF for PX30 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index 7dc5ce8..46e27cd 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -13,6 +13,7 @@ On RK3328 SoCs, the GRF adds a section for USB2PHYGRF,
 Required Properties:
 
 - compatible: GRF should be one of the following:
+   - "rockchip,px30-grf", "syscon": for px30
    - "rockchip,rk3036-grf", "syscon": for rk3036
    - "rockchip,rk3066-grf", "syscon": for rk3066
    - "rockchip,rk3188-grf", "syscon": for rk3188
@@ -23,6 +24,7 @@ Required Properties:
    - "rockchip,rk3399-grf", "syscon": for rk3399
    - "rockchip,rv1108-grf", "syscon": for rv1108
 - compatible: PMUGRF should be one of the following:
+   - "rockchip,px30-pmugrf", "syscon": for px30
    - "rockchip,rk3368-pmugrf", "syscon": for rk3368
    - "rockchip,rk3399-pmugrf", "syscon": for rk3399
 - compatible: SGRF should be one of the following
-- 
1.9.1
