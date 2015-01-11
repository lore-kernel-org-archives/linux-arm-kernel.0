From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 11 Jan 2015 23:01:48 +0800
Subject: [GIT PULL] CSR atlas7 debug ports for 3.20
Message-ID: <CAGsJ_4z5h77BJu5D5nj3zSmiO_WUdTOb1nRy5NCykueSSDDkrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:

  Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

for you to fetch changes up to e5bd2e9be6e5a8aecb79913f99a91f143f2b5191:

  ARM: sirf: add two debug ports for CSRatlas7 SoC (2015-01-11 22:53:34 +0800)

----------------------------------------------------------------
add debug ports for CSR atlas7

- drop marco's debug port
- add debug ports for atlas7
- move to use DEBUG_UART_PHYS/VIRT for all CSR ports

----------------------------------------------------------------
Barry Song (1):
      ARM: sirf: drop MARCO low-level debug port

Guo Zeng (1):
      ARM: sirf: add two debug ports for CSRatlas7 SoC

 arch/arm/Kconfig.debug        |   37 ++++++++++++++++++++++++++++++-------
 arch/arm/include/debug/sirf.S |   30 +++++++++++++-----------------
 arch/arm/mach-prima2/lluart.c |    2 --
 3 files changed, 43 insertions(+), 26 deletions(-)

-barry
