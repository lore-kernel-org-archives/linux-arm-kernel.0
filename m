From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Dec 2017 22:40:41 +0100
Subject: [PATCH v2 0/2] ARM: dts: r8a7743: move timer nodes nodes out of bus
Message-ID: <20171218214043.10796-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the timer node, which have no reg property, out of the root node.
The nodes that have been moved do not have any register properties and thus
shouldn't be placed on the bus.

In preparation for the above sort nodes in the root node alphabetically.

Based renesas-devel-20171218-v4.15-rc4

Changes since v1:
* Rebase
* Avoid line-wrapping nodes

Simon Horman (2):
  ARM: dts: r8a7743: sort root sub-nodes alphabetically
  ARM: dts: r8a7743: move timer node out of bus

 arch/arm/boot/dts/r8a7743.dtsi | 116 +++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 56 deletions(-)

-- 
2.11.0
