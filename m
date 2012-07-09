From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 9 Jul 2012 15:51:34 +0530
Subject: [GIT PULL] DaVinci SoC updates for v3.6
Message-ID: <4FFAB0AE.3010508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following DaVinci SoC updates for v3.6?

Thanks,
Sekhar

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-v3.6-soc

for you to fetch changes up to ce9dcb8784611c50974d1c6b600c71f5c0a29308:

  ARM: davinci: add runtime PM support for clock management (2012-07-01 17:26:26 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v3.6

Add IRQ domain support for cp_intc and
runtime PM core support for DaVinci devices.

----------------------------------------------------------------
Heiko Schocher (1):
      ARM: davinci: cp_intc: Add irq domain support

Kevin Hilman (1):
      ARM: davinci: add runtime PM support for clock management

 arch/arm/mach-davinci/Kconfig     |    1 +
 arch/arm/mach-davinci/Makefile    |    1 +
 arch/arm/mach-davinci/cp_intc.c   |   63 ++++++++++++++++++++++++++++--------
 arch/arm/mach-davinci/pm_domain.c |   64 +++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-davinci/pm_domain.c
