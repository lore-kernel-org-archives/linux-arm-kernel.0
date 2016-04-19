From: van.freenix@gmail.com (Peng Fan)
Date: Tue, 19 Apr 2016 16:59:12 +0800
Subject: [PATCH 1/3] documentation: nvmem: imx-ocotp: Add i.MX6UL support
Message-ID: <1461056354-973-1-git-send-email-van.freenix@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX6UL support in documentation.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 383d588..ca2075b 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -1,13 +1,14 @@
 Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, and i.MX6SX SoCs.
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, and i.MX6UL SoCs.
 
 Required properties:
 - compatible: should be one of
 	"fsl,imx6q-ocotp" (i.MX6Q/D/DL/S),
 	"fsl,imx6sl-ocotp" (i.MX6SL), or
-	"fsl,imx6sx-ocotp" (i.MX6SX), followed by "syscon".
+	"fsl,imx6sx-ocotp" (i.MX6SX), or
+	"fsl,imx6ul-ocotp" (i.MX6UL), followed by "syscon".
 - reg: Should contain the register base and length.
 - clocks: Should contain a phandle pointing to the gated peripheral clock.
 
-- 
1.8.4.5
