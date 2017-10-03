From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:52:56 +0530
Subject: [PATCH 0/4] Few more SBA RAID driver improvements
Message-ID: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does few more improvements to Broadcom SBA RAID
driver.

The patches are based on Linux-4.14-rc3 and can also be found
at sba-raid-imp2-v1 branch of:
https://github.com/Broadcom/arm64-linux.git

Anup Patel (4):
  dmaengine: bcm-sba-raid: serialize dma_cookie_complete() using
    reqs_lock
  dmaengine: bcm-sba-raid: Use only single mailbox channel
  dmaengine: bcm-sba-raid: Use common GPL comment header
  dmaengine: Build bcm-sba-raid driver as loadable module for iProc SoCs

 drivers/dma/Kconfig        |   2 +-
 drivers/dma/bcm-sba-raid.c | 117 ++++++++++++++-------------------------------
 2 files changed, 38 insertions(+), 81 deletions(-)

-- 
2.7.4
