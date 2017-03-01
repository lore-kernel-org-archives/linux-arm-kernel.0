From: peng.fan@nxp.com (Peng Fan)
Date: Wed, 1 Mar 2017 14:40:52 +0800
Subject: [PATCH 1/3] dt-bindings: imx-ocotp: add compatible string for i.MX7D/S
Message-ID: <1488350454-23860-1-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string for i.MX7D/S

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 966a72e..bbde2e4 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -9,6 +9,7 @@ Required properties:
 	"fsl,imx6sl-ocotp" (i.MX6SL), or
 	"fsl,imx6sx-ocotp" (i.MX6SX),
 	"fsl,imx6ul-ocotp" (i.MX6UL),
+	"fsl,imx7d-ocotp" (i.MX7D/S),
 	followed by "syscon".
 - reg: Should contain the register base and length.
 - clocks: Should contain a phandle pointing to the gated peripheral clock.
-- 
2.6.6
