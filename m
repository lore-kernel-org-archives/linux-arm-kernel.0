From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 14 Jan 2015 21:24:19 +0800
Subject: [GIT PULL RESEND] CSR atlas7 debug ports for 3.20
Message-ID: <CAGsJ_4yJTApS6RwGCEFcBGT+L1f8Gn3DnmzGAKQc3H2SZZJvcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:

  Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/atlas7-lldebug-for-3.20

for you to fetch changes up to 98898ee43a94375cf814b86fb7f485c39fb2c072:

  ARM: sirf: add two debug ports for CSRatlas7 SoC (2015-01-14 20:56:09 +0800)

----------------------------------------------------------------
add debug ports for CSRatlas7 SoC

Because Marco chip has never shipped to customers and has been replaced
by Atlas7, so we do the below
- drop Marco's debug port
- add debug ports for Atlas7

we also move to use DEBUG_UART_PHYS/VIRT for all CSR ports

----------------------------------------------------------------
Barry Song (1):
      ARM: sirf: drop Marco low-level debug port

Guo Zeng (1):
      ARM: sirf: add two debug ports for CSRatlas7 SoC

 arch/arm/Kconfig.debug        |   37 ++++++++++++++++++++++++++++++-------
 arch/arm/include/debug/sirf.S |   30 +++++++++++++-----------------
 arch/arm/mach-prima2/lluart.c |    2 --
 3 files changed, 43 insertions(+), 26 deletions(-)

-barry
