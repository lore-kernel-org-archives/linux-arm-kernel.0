From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 11 May 2011 14:07:37 +0300
Subject: [GIT PULL 0/3] TrimSlice updates for 2.6.40
Message-ID: <cover.1305105580.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,
Please consider pulling TrimSlice updates for 2.6.40 merge window.
These patches add registration of i2c, audio and USB devices.

The following changes since commit 9f381a61f58bb6487c93ce2233bb9992f8ea9211:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 (2011-05-10 17:39:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux-tegra.git trimslice/upstream

Mike Rapoport (3):
      ARM: tegra: trimslice: register i2c busses and devices
      ARM: tegra: trimslice: add audio devices and clocks
      ARM: tegra: trimslice: enable USB ports

 arch/arm/mach-tegra/board-trimslice-pinmux.c |    2 +-
 arch/arm/mach-tegra/board-trimslice.c        |   92 ++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletions(-)
