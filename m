From: olof@lixom.net (Olof Johansson)
Date: Tue, 7 Feb 2012 16:09:44 -0800
Subject: [GIT PULL] please pull tegra fixes for 3.3-rc
Message-ID: <CAOesGMhCC5axuZMZ9qcwqqitM2iUScd=SJPiGH=5A9gRYEDTbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git fixes

for you to fetch changes up to 0783a9bf4a5207e9d57b8c110022957f8dc88e2a:

  ARM: tegra: paz00: fix wrong UART port on mini-pcie plug (2012-02-06
18:32:51 -0800)

----------------------------------------------------------------
Marc Dietrich (2):
      ARM: tegra: paz00: fix wrong SD1 power gpio
      ARM: tegra: paz00: fix wrong UART port on mini-pcie plug

Olof Johansson (1):
      ARM: tegra: dma: fix buildbreak for !CONFIG_TEGRA_SYSTEM_DMA

Shubhrajyoti Datta (1):
      i2c: tegra: Add devexit_p() for remove

 arch/arm/boot/dts/tegra-paz00.dts      |    6 +++---
 arch/arm/mach-tegra/board-paz00.c      |    8 ++++----
 arch/arm/mach-tegra/board-paz00.h      |    2 +-
 arch/arm/mach-tegra/include/mach/dma.h |   10 +++++-----
 drivers/i2c/busses/i2c-tegra.c         |    2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)
