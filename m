From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 4 Apr 2017 14:55:45 +0530
Subject: [GIT PULL 2/4] DaVinci SoC support updates for v4.12 (part 2)
In-Reply-To: <20170404092547.32480-1-nsekhar@ti.com>
References: <20170404092547.32480-1-nsekhar@ti.com>
Message-ID: <20170404092547.32480-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 99228481331cdd75981767b23b83ef0ca7aa11da:

  ARM: davinci: add pdata-quirks for da850-evm vpif display (2017-03-07 16:43:19 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/soc-2

for you to fetch changes up to 28d4d1d0e49b4ac4d12861a64f45101f36fbfab8:

  ARM: davinci: add pata_bk3710 libata driver support (2017-03-30 16:15:29 +0530)

----------------------------------------------------------------
Add platform support needed for the
newly introduced PalmChip PATA driver.

----------------------------------------------------------------
Sekhar Nori (1):
      ARM: davinci: add pata_bk3710 libata driver support

 arch/arm/mach-davinci/board-dm644x-evm.c  | 3 ++-
 arch/arm/mach-davinci/board-dm646x-evm.c  | 3 ++-
 arch/arm/mach-davinci/board-neuros-osd2.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)
