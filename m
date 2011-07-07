From: mike@compulab.co.il (Mike Rapoport)
Date: Thu,  7 Jul 2011 09:04:32 +0300
Subject: [GIT PULL v3 0/3] TrimSlice updates for 3.1
Message-ID: <cover.1309955711.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,
Please consider pulling TrimSlice updates for 3.1 merge window.
These patches add registration of i2c, audio and USB devices.

v3 changes:
- rebased on top of current Linus tree

v2 changes:
- update CDEV1 pinmux as per Stephen suggestion
- use GPIO table for USB-related GPIOs

The following changes since commit a2fa83faf47b514ab947cea916d3691b66525073:

  Merge branch 'usb-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6 (2011-07-05 20:57:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux-tegra.git trimslice/upstream

Mike Rapoport (3):
      ARM: tegra: trimslice: register i2c busses and devices
      ARM: tegra: trimslice: add audio devices and clocks
      ARM: tegra: trimslice: enable USB ports

 arch/arm/mach-tegra/board-trimslice-pinmux.c |    7 ++-
 arch/arm/mach-tegra/board-trimslice.c        |   92 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-trimslice.h        |    3 +
 3 files changed, 100 insertions(+), 2 deletions(-)
