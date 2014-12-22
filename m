From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 22 Dec 2014 17:42:01 +0530
Subject: [PATCH v3 0/3] mmc: dw_mmc: update host driver with minor fixes
Message-ID: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is part of [1] which are send by Seungwon jeon few months back.
when he attempted to add HS400 support for exynos dw_mmc host controller.
Since then these patches are just sitting idle.
This is my attempt to land some of the changes which are generic, and performance
booter on dw_mmc host controller.

These patches are already ACKed by Jaehoon Chung.

[1] http://www.spinics.net/lists/linux-samsung-soc/msg27903.html

Changes in v3:
      None, just a rebase on ulf's next branch.


Seungwon Jeon (3):
  mmc: dw_mmc: fix the max_blk_count in IDMAC
  mmc: dw_mmc: exynos: don't use if clock isn't available
  mmc: dw_mmc: exynos: move definitions to header file

 drivers/mmc/host/dw_mmc-exynos.c |   59 +++++++++-----------------------------
 drivers/mmc/host/dw_mmc-exynos.h |   56 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c        |    4 +--
 3 files changed, 71 insertions(+), 48 deletions(-)
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.h

-- 
1.7.9.5
