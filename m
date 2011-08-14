From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Aug 2011 00:35:48 -0700
Subject: [GIT PULL] [3.2] Please pull tegra boards for 3.2
Message-ID: <CAOesGMjHN-pvVfMN0o3AD238m8wEiRS-D4ArjV_2VAGTuwPfBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the first set of tegra/board patches for 3.2:


The following changes since commit e6a99d312687a42c077a9b8cb5e757f186edb1b9:

  Merge branch 'slab/urgent' of
git://git.kernel.org/pub/scm/linux/kernel/git/penberg/slab-2.6
(2011-08-09 08:42:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git boards-for-3.2

Marc Dietrich (5):
      ARM: tegra: paz00: add support serial port on JP1
      ARM: tegra: paz00: enable rfkill for internal wifi card
      ARM: tegra: paz00: enable wifi led
      ARM: tegra: paz00: reorder the SDHCI channel init
      ARM: tegra: paz00: add clocks required for usb operation

Stephen Warren (4):
      ARM: Tegra: Harmony: Add USB device
      ARM: Tegra: Seaboard board updates for audio
      ARM: Tegra: Seaboard: Add USB devices
      ARM: Tegra: Force PORT_TEGRA as the UART type

 arch/arm/mach-tegra/board-harmony.c         |    5 +-
 arch/arm/mach-tegra/board-paz00-pinmux.c    |    3 +
 arch/arm/mach-tegra/board-paz00.c           |   62 ++++++++++++++++++++-
 arch/arm/mach-tegra/board-paz00.h           |   16 ++++-
 arch/arm/mach-tegra/board-seaboard-pinmux.c |    6 +-
 arch/arm/mach-tegra/board-seaboard.c        |   81 ++++++++++++++++++++++++++-
 arch/arm/mach-tegra/board-seaboard.h        |   12 +++-
 arch/arm/mach-tegra/board-trimslice.c       |    3 +-
 8 files changed, 173 insertions(+), 15 deletions(-)
