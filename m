From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 12 Apr 2017 14:14:52 +0530
Subject: [GIT PULL] DaVinci SoC updates for v4.12 (part 3)
Message-ID: <90b39c89-450c-9ac2-2c69-ab2166986a8b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 28d4d1d0e49b4ac4d12861a64f45101f36fbfab8:

  ARM: davinci: add pata_bk3710 libata driver support (2017-03-30 16:15:29 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/soc-3

for you to fetch changes up to 398dbc776a8f7dfdee7c38ad003e66abd31b3b0a:

  ARM: davinci: Add clock for CPPI 4.1 DMA engine (2017-04-11 19:50:53 +0530)

----------------------------------------------------------------
Add clock for CPPI 4.1 DMA engine thats
part of USB OTG subsystem on DA830 and
DA850.

This builds on top of the pull request
sent earlier:
https://www.spinics.net/lists/arm-kernel/msg573985.html

----------------------------------------------------------------
Alexandre Bailon (1):
      ARM: davinci: Add clock for CPPI 4.1 DMA engine

 arch/arm/mach-davinci/da830.c | 6 ++++++
 arch/arm/mach-davinci/da850.c | 6 ++++++
 2 files changed, 12 insertions(+)
