From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 11:19:21 +0100
Subject: [PATCH 0/2] ARM: dts: r8a7743: Timer node nodes out of bus
Message-ID: <20171207101923.19846-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the timer node, which have no reg property, out of the root node.
The nodes that have been moved do not have any register properties and thus
shouldn't be placed on the bus.

In preparation for the above sort nodes in the root node alphabetically.

Based on renesas-devel-20171207-v4.15-rc2

Simon Horman (2):
  ARM: dts: r8a7743: sort root sub-nodes alphabetically
  ARM: dts: r8a7743: move timer node out of bus

 arch/arm/boot/dts/r8a7743.dtsi | 86 ++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

-- 
2.11.0
