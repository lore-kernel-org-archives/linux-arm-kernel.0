From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 26 Sep 2010 00:19:06 -0600 (MDT)
Subject: [GIT PULL] OMAP: hwmod/device/CM: bug fixes for 2.6.37
Message-ID: <alpine.DEB.2.00.1009260018060.10678@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following changes since commit 74ff3a68ed11f1e9eede4fe301f42cc3cdf7396a:

  OMAP: hwmod: improve documentation, clean up function names (2010-09-22 09:19:55 -0600)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 misc_2.6.37

Hema HK (1):
      OMAP: hwmod: Set autoidle after smartidle during _sysc_enable

Kishon Vijay Abraham I (1):
      OMAP: omap_device: Fix to support multiple hwmods for a single device

Rajendra Nayak (1):
      OMAP4: PM: Declare idle modules as functional too

 arch/arm/mach-omap2/cm4xxx.c     |    9 +++++----
 arch/arm/mach-omap2/omap_hwmod.c |   17 +++++++++++------
 arch/arm/plat-omap/omap_device.c |   35 ++++++++++++++---------------------
 3 files changed, 30 insertions(+), 31 deletions(-)


- Paul
