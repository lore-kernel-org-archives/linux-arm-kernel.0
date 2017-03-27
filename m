From: cl@rock-chips.com (cl at rock-chips.com)
Date: Mon, 27 Mar 2017 17:40:47 +0800
Subject: [PATCH v4 3/6] dt-bindings: soc: rockchip: grf: add support for rk3328
In-Reply-To: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Message-ID: <1490607650-18650-3-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Signed-off-by: Liang Chen <cl@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index a0685c2..de8b983 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -16,6 +16,7 @@ Required Properties:
    - "rockchip,rk3188-grf", "syscon": for rk3188
    - "rockchip,rk3228-grf", "syscon": for rk3228
    - "rockchip,rk3288-grf", "syscon": for rk3288
+   - "rockchip,rk3328-grf", "syscon": for rk3328
    - "rockchip,rk3368-grf", "syscon": for rk3368
    - "rockchip,rk3399-grf", "syscon": for rk3399
 - compatible: PMUGRF should be one of the following:
-- 
1.9.1
