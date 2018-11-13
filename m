From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Tue, 13 Nov 2018 18:29:49 +0200
Subject: [PATCH v2 0/2] dpaa_eth: add ethtool coalesce control
Message-ID: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add control of the DPAA portal interrupt coalescing settings from
ethtool.

changes from v1: added range checking for the QMan APIs

Madalin Bucur (2):
  soc/qman: add return value to interrupt coalesce changing APIs
  dpaa_eth: add ethtool coalesce control

 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 49 ++++++++++++++++++++++
 drivers/soc/fsl/qbman/qman.c                       | 33 +++++++++++----
 include/soc/fsl/qman.h                             |  8 +++-
 3 files changed, 81 insertions(+), 9 deletions(-)

-- 
2.1.0
