From: cl@rock-chips.com (cl at rock-chips.com)
Date: Wed, 15 Mar 2017 18:03:54 +0800
Subject: [PATCH v1 4/7] dt-bindings: soc: rockchip: grf: add support for rk3328
In-Reply-To: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
Message-ID: <1489572237-6649-5-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Liang <cl@rock-chips.com>

Signed-off-by: Chen Liang <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index a0685c2..db4da0b 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -18,6 +18,7 @@ Required Properties:
    - "rockchip,rk3288-grf", "syscon": for rk3288
    - "rockchip,rk3368-grf", "syscon": for rk3368
    - "rockchip,rk3399-grf", "syscon": for rk3399
+   - "rockchip,rk3328-grf", "syscon": for rk3328
 - compatible: PMUGRF should be one of the following:
    - "rockchip,rk3368-pmugrf", "syscon": for rk3368
    - "rockchip,rk3399-pmugrf", "syscon": for rk3399
-- 
1.9.1
