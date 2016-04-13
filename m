From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Wed, 13 Apr 2016 16:05:10 -0500
Subject: [PATCH 0/2 v2] fsl-mc binding and device tree updates
Message-ID: <1460581510-32056-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a few missing things from the binding
for the fsl-mc node on the ls2080a Soc-- msi-parent, ranges,
dpmac definition.  The ls2080a device tree is updated to
reflect the binding updates.

-v2
   -added ack to binding patch
   -updated whitespace and comment in dts patch

Stuart Yoder (2):
  Documentation: fsl-mc: binding updates for MSIs, ranges, PHYs
  arm64: dts: ls2080a: fsl-mc dt node updates

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 81 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 98 ++++++++++++++++++++++
 2 files changed, 178 insertions(+), 1 deletion(-)

-- 
1.9.0
