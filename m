From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 18:09:18 +0900
Subject: [PATCH v6 0/3] ARM: shmobile: lager: enable Ether
Message-ID: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this short series enables the on-board ethernet
of the r8a7790 SoC for on lager board.

It has a run-time dependency on
"sh_eth: add support for r8a7790 SoC"

It has been built on top of renesas-next-20130726.

Changes noted in changelogs of individual patches.

Simon Horman (3):
  ARM: shmobile: r8a7790: clocks for Ether support
  ARM: shmobile: lager: enable Ether
  ARM: shmobile: lager: enable nfsroot in DTS

 arch/arm/boot/dts/r8a7790-lager.dts    |  2 +-
 arch/arm/mach-shmobile/board-lager.c   | 30 ++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 3 files changed, 35 insertions(+), 1 deletion(-)

-- 
1.8.3.2
