From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 17:48:00 +0900
Subject: [PATCH 0/8] ARM: shmobile: Conditionally select SMSC_PHY
Message-ID: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the SMSC_PHY if ethernet is enabled on shmbile boards
that have an SMSC phy. This allows the SMSC-specific phy driver
to be used rather than relying on generic phy code.

Based on the renesas-devel-v3.13-rc7-20140107 tag
of my renesas tree.

Simon Horman (8):
  ARM: shmobile: ape6evm: Conditionally select SMSC_PHY
  ARM: shmobile: armadillo800eva: Conditionally select SMSC_PHY
  ARM: shmobile: bockw: Sort Kconfig node's selections
  ARM: shmobile: bockw: Conditionally select SMSC_PHY
  ARM: shmobile: kzm9d: Conditionally select SMSC_PHY
  ARM: shmobile: kzm9g: Conditionally select SMSC_PHY
  ARM: shmobile: mackerel: Conditionally select SMSC_PHY
  ARM: shmobile: marzen: Conditionally select SMSC_PHY

 arch/arm/mach-shmobile/Kconfig | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
1.8.4
