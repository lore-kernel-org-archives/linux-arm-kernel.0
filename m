From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 19 Sep 2012 13:21:09 +0530
Subject: [GIT PULL] ARM: OMAP5: Enable arch timer support
Message-ID: <1348041069-947-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Here is the pull request which enables the architected cpu local timer
support for OMAP5 devices.

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git at github.com:SantoshShilimkar/linux.git for_3.7/omap5_arch_timer

for you to fetch changes up to 3c7c5dab44d6c8861bc86dab924353d8d40344f8:

  ARM: OMAP5: Enable arch timer support (2012-09-19 13:00:37 +0530)

----------------------------------------------------------------
Santosh Shilimkar (2):
      ARM: OMAP: Add initialisation for the real-time counter.
      ARM: OMAP5: Enable arch timer support

 arch/arm/boot/dts/omap5.dtsi |   12 ++++++
 arch/arm/mach-omap2/Kconfig  |    5 +++
 arch/arm/mach-omap2/timer.c  |   97 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 1 deletion(-)
