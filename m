From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 22 Mar 2018 11:24:19 +0100
Subject: [PATCH v2 0/4] arm64: dts: renesas: r8a779[56]: sort nodes
Message-ID: <20180322102423.18269-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort nodes of the R-Car H3 (r8a7795) and M3-W (r8a7796) DTs.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Based on renesas-devel-20180321-v4.16-rc6


Changes since v1:
* Dropped sorting of r8a7795 CPU nodes, they are already sorted
* Rebase r8a7795 patches
* Add r8a7796 patches

Simon Horman (4):
  arm64: dts: renesas: r8a7795: sort subnodes of the root node
  arm64: dts: renesas: r8a7795: sort subnodes of the soc node
  arm64: dts: renesas: r8a7796: sort subnodes of the root node
  arm64: dts: renesas: r8a7796: sort subnodes of the soc node

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1904 +++++++++++++++---------------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 1840 ++++++++++++++---------------
 2 files changed, 1872 insertions(+), 1872 deletions(-)

-- 
2.11.0
