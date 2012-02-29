From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 29 Feb 2012 09:17:20 +0200
Subject: [PATCH V2 0/1] mmc: start removing enable / disable API
Message-ID: <1330499841-6879-1-git-send-email-adrian.hunter@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Most parts of the enable / disable API are no longer used and
can be removed.

V2: fix missing enable in mmc_try_claim_host as per Sujit Reddy Thumma


Adrian Hunter (1):
      mmc: start removing enable / disable API

 arch/arm/mach-exynos/mach-nuri.c           |    5 +-
 arch/arm/mach-exynos/mach-universal_c210.c |    9 +-
 drivers/mmc/core/core.c                    |  187 +++-------------------------
 drivers/mmc/core/host.c                    |    1 -
 drivers/mmc/core/host.h                    |    1 -
 drivers/mmc/host/davinci_mmc.c             |    4 -
 drivers/mmc/host/omap_hsmmc.c              |   15 +--
 include/linux/mmc/core.h                   |    1 -
 include/linux/mmc/host.h                   |   46 +------
 9 files changed, 27 insertions(+), 242 deletions(-)


Regards
Adrian
