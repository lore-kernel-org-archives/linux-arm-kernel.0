From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Dec 2017 22:32:31 +0100
Subject: [PATCH 0/2] ARM: dts: r8a7792: Timer node nodes out of bus
Message-ID: <20171218213233.3373-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the timer node, which have no reg property, out of the root node.
The nodes that have been moved do not have any register properties and thus
shouldn't be placed on the bus.

In preparation for the above sort nodes in the root node alphabetically.

Based on renesas-devel-20171218-v4.15-rc4

Simon Horman (2):
  ARM: dts: r8a7792: sort root sub-nodes alphabetically
  ARM: dts: r8a7792: move timer node out of bus

 arch/arm/boot/dts/r8a7792.dtsi | 64 ++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

-- 
2.11.0
