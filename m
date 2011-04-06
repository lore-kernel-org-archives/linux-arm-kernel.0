From: khilman@ti.com (Kevin Hilman)
Date: Wed, 06 Apr 2011 08:26:36 -0700
Subject: [GIT PULL] OMAP PM fixes for 2.6.39-rc
Message-ID: <87sjtvieoj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following OMAP PM fixes for the 2.6.39-rc fixes cycle.

Thanks,

Kevin

The following changes since commit 6221f222c0ebf1acdf7abcf927178f40e1a65e2a:

  Linux 2.6.39-rc2 (2011-04-05 18:30:43 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.39/pm-fixes

Aaro Koskinen (5):
      OMAP3+: smartreflex: fix sr_late_init() error path in probe
      OMAP3+: smartreflex: request the memory region
      OMAP3+: smartreflex: fix ioremap leak on probe error
      OMAP3+: smartreflex: delete instance from sr_list on probe error
      OMAP3+: smartreflex: delete debugfs entries on probe error

Nishanth Menon (3):
      OMAP3+: voltage: remove initial voltage
      OMAP3+: voltage: remove spurious pr_notice for debugfs
      OMAP4: PM: remove redundant #ifdef CONFIG_PM

Shweta Gulati (1):
      OMAP4: Intialize IVA Device in addition to DSP device.

 arch/arm/mach-omap2/pm.c          |    1 +
 arch/arm/mach-omap2/pm44xx.c      |    2 --
 arch/arm/mach-omap2/smartreflex.c |   23 ++++++++++++++++++-----
 arch/arm/mach-omap2/voltage.c     |    2 --
 4 files changed, 19 insertions(+), 9 deletions(-)
