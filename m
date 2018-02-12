From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Feb 2018 15:39:26 +0100
Subject: [PATCH 0/4] ARM: dts: r7s72100: add soc node
Message-ID: <20180212143930.4763-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset adds an soc node, moves all nodes for IP blocks with an
address on the bus to be sub nodes of the soc node, removes the clock node
and sorts subnodes of the root and soc nodes.

This brings the DTS of the r7s72100 in line with that of R-Car Gen 2 SoCs.

Simon Horman (4):
  ARM: dts: r7s72100: add soc node
  ARM: dts: r7s72100: sort subnodes of soc node
  ARM: dts: r7s72100: stop grouping clocks under a "clocks" subnode
  ARM: dts: r7s72100: sort subnodes of root node

 arch/arm/boot/dts/r7s72100.dtsi | 1038 ++++++++++++++++++++-------------------
 1 file changed, 521 insertions(+), 517 deletions(-)

-- 
2.11.0
