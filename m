From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  6 Aug 2013 16:50:08 +0900
Subject: [PATCH v7 0/3] ARM: shmobile: lager: enable Ether
Message-ID: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this short series enables the on-board ethernet
of the r8a7790 SoC for on lager board.

This series has a run-time dependency on
"sh_eth: add support for r8a7790 SoC"

This series has been built on top of renesas-next-201300806.

Changes noted in changelogs of individual patches.
Simon Horman (3):
  ARM: shmobile: r8a7790: clocks for Ether support
  ARM: shmobile: lager: enable Ether
  ARM: shmobile: lager: enable nfsroot in DTS

 arch/arm/boot/dts/r8a7790-lager.dts    |  2 +-
 arch/arm/mach-shmobile/board-lager.c   | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
1.8.3.2
