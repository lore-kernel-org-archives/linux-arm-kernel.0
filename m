From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jul 2012 02:27:10 -0700
Subject: [GIT PULL] omap fixes for v3.5-rc5
Message-ID: <20120705092709.GW1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Here are few more PM related fixes for the -rc series. If you think
these are too intrusive at this point, let me know.

Regards,

Tony


The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.5-rc5

for you to fetch changes up to fa2976a811a764573b2a9c79126d4d66f1f16268:

  Merge tag 'omap-fixes-b-for-3.5rc' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into fixes (2012-07-05 01:12:08 -0700)

----------------------------------------------------------------

PM related fixes for omaps mostly to get suspend/resume
working again.

----------------------------------------------------------------
Benoit Cousson (1):
      ARM: OMAP2+: hwmod data: Fix wrong McBSP clock alias on OMAP4

Kevin Hilman (2):
      ARM: OMAP2: Overo: init I2C before MMC to fix MMC suspend/resume failure
      ARM: OMAP4: TWL6030: ensure sys_nirq1 is mux'd and wakeup enabled

Paul Walmsley (1):
      ARM: OMAP4: hwmod data: temporarily comment out data for the usb_host_fs and aess IP blocks

Tony Lindgren (1):
      Merge tag 'omap-fixes-b-for-3.5rc' of git://git.kernel.org/.../pjw/omap-pending into fixes

 arch/arm/mach-omap2/board-overo.c          |  2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 28 ++++++++++++++--------------
 arch/arm/mach-omap2/twl-common.c           |  2 ++
 3 files changed, 17 insertions(+), 15 deletions(-)
