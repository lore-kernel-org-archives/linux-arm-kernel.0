From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Thu, 20 Sep 2018 18:06:47 +0300
Subject: [PATCH 0/4] soc/fsl/qbman: DPAA QBMan fixes and additions
Message-ID: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set brings a number of fixes and the option to control
the QMan portal interrupt coalescing.

Madalin Bucur (1):
  soc/fsl_qbman: export coalesce change API

Roy Pledge (3):
  soc/fsl/qbman: Check if CPU is offline when initializing portals
  soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
  soc/fsl/qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig |  2 +-
 drivers/soc/fsl/qbman/bman.c  | 17 ++++++++---
 drivers/soc/fsl/qbman/qman.c  | 65 ++++++++++++++++++++++++++++++++++++++-----
 include/soc/fsl/qman.h        | 27 ++++++++++++++++++
 4 files changed, 99 insertions(+), 12 deletions(-)

-- 
2.1.0
