From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 16 May 2011 23:22:33 +0300
Subject: [GIT PULL v2 0/3] TrimSlice updates for 2.6.40
Message-ID: <cover.1305576864.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,
Please consider pulling TrimSlice updates for 2.6.40 merge window.
These patches add registration of i2c, audio and USB devices.

v2 changes:
- update CDEV1 pinmux as per Stephen suggestion
- use GPIO table for USB-related GPIOs

The following changes since commit eed631e0d741d1a1067cfc6d709fdf2363126f9c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-unstable (2011-05-15 10:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux-tegra.git trimslice/upstream

Mike Rapoport (3):
      ARM: tegra: trimslice: register i2c busses and devices
      ARM: tegra: trimslice: add audio devices and clocks
      ARM: tegra: trimslice: enable USB ports

 arch/arm/mach-tegra/board-trimslice-pinmux.c |    7 ++-
 arch/arm/mach-tegra/board-trimslice.c        |   91 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-trimslice.h        |    3 +
 3 files changed, 99 insertions(+), 2 deletions(-)
