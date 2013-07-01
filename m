From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  1 Jul 2013 11:18:38 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: lager: Add DT reference
Message-ID: <1372645120-27256-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds DT reference to Lager.

The intention of this is to allow the board to be
brought up as much as possible using DT. And for
this to act as a basis for further DT coverage
of devices present on the Lager and its r8a7790 SoC.


This series differs from v2 in that it has been
rebased on top of reneas-next-20130701 and now makes use
of r8a7790_init_delay().


Simon Horman (2):
  ARM: shmobile: r8a7790:  Initialise clocks and SCIF in
    r8a7790_add_dt_devices()
  ARM: shmobile: lager: Add DT reference

 arch/arm/boot/dts/Makefile                     |  1 +
 arch/arm/boot/dts/r8a7790-lager-reference.dts  | 31 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                 | 11 ++++++++
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/board-lager-reference.c | 37 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h  |  1 +
 arch/arm/mach-shmobile/setup-r8a7790.c         | 11 +++++++-
 7 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a7790-lager-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-lager-reference.c

-- 
1.8.2.1
