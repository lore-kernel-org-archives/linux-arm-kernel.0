From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 17 Feb 2011 11:24:41 +0100
Subject: [PATCH 0/8] OMAP4: hwmod data: Add a bunch of IPs
Message-ID: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All, 

Due to the important number of modifications recently done on the
OMAP4 data compared to the original and the total absence of explanation
in the changelog, I re-submit the data before the driver series in order
to maintain the integrity of the original file and to avoid a huge pain
during the merge.

Govind, Tarun and Kishon, 
Please note that I cannot include here the dev_attr or rev field for
McSPI, McBSP and timer since it requires some modification in the device
header.
You will have to update your series accordingly.

A couple of extra hwmod are added as well to avoid the future drivers
series to include them.
The various USB OMAP4 hwmods data will be send soon.

Regards,
Benoit

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Charulatha V <charu@ti.com>
Cc: David Lambert <dlambert@ti.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
  Linus Torvalds (1):
        Linux 2.6.38-rc5

are available in the git repository at:

  git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data

Benoit Cousson (8):
  OMAP4: hwmod data: Add hwspinlock
  OMAP4: hwmod data: Add McSPI
  OMAP4: hwmod data: Add timer
  OMAP4: hwmod data: Add DSS, DISPC, DSI1&2, RFBI, HDMI and VENC
  OMAP4: hwmod data: Add mailbox
  OMAP4: hwmod data: Add DMIC
  OMAP4: hwmod data: Add McBSP
  OMAP4: hwmod data: Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 3023 +++++++++++++++++++++++++++-
 1 files changed, 2977 insertions(+), 46 deletions(-)
