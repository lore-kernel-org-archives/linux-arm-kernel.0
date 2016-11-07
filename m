From: ping.bai@nxp.com (Bai Ping)
Date: Mon, 7 Nov 2016 13:41:20 +0800
Subject: [PATCH 2/3] devicetree: bindings: nvmem: Add compatible string for
 imx6ul
In-Reply-To: <1478497281-5477-1-git-send-email-ping.bai@nxp.com>
References: <1478497281-5477-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1478497281-5477-2-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new compatible string for i.MX6UL SOC.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 383d588..a7ff65d 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -1,13 +1,14 @@
 Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, and i.MX6SX SoCs.
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX and i.MX6UL SoCs.
 
 Required properties:
 - compatible: should be one of
 	"fsl,imx6q-ocotp" (i.MX6Q/D/DL/S),
-	"fsl,imx6sl-ocotp" (i.MX6SL), or
-	"fsl,imx6sx-ocotp" (i.MX6SX), followed by "syscon".
+	"fsl,imx6sl-ocotp" (i.MX6SL),
+	"fsl,imx6sx-ocotp" (i.MX6SX), or
+	"fsl,imx6ul-ocotp" (i.MX6UL), followed by "syscon".
 - reg: Should contain the register base and length.
 - clocks: Should contain a phandle pointing to the gated peripheral clock.
 
-- 
2.8.2
