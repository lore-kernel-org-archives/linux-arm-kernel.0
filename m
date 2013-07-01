From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  1 Jul 2013 13:25:52 +0900
Subject: [PATCH v3 0/3] ARM: shmobile: lager: enable Ether
Message-ID: <1372652755-16948-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series enables the on-board ethernet
of the r8a7790 SoC for on lager baord.

It is based on the renesas-next-20130509 tag of my renesas tree.

It has a run-time dependency on
"sh_eth: add support for r8a7790 SoC"

It has been built on top of renesas-next-20130701.

Simon Horman (3):
  ARM: shmobile: r8a7790: add Ether support
  ARM: shmobile: lager: enable Ether
  ARM: shmobile: lager: enable nfsroot in DTS

 arch/arm/boot/dts/r8a7790-lager.dts           |  2 +-
 arch/arm/mach-shmobile/board-lager.c          | 24 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c        |  4 ++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 14 ++++++++++++++
 5 files changed, 46 insertions(+), 1 deletion(-)

-- 
1.8.2.1
