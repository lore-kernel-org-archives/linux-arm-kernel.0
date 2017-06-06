From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:23 -0500
Subject: [PATCH 00/18] staging: fsl-dpaa2/eth: Code cleanup and minor fixes
Message-ID: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains fixes for a few minor bugs and
code cleanup and cosmetics. No significant functional changes.

Ioana Radulescu (18):
  staging: fsl-dpaa2/eth: Add "static" keyword where needed
  staging: fsl-dpaa2/eth: Initialize variable before use
  staging: fsl-dpaa2/eth: Fix return type of ndo_start_xmit
  staging: fsl-dpaa2/eth: Remove incorrect error path
  staging: fsl-dpaa2/eth: Add error message newlines
  staging: fsl-dpaa2/eth: Minor cleanup in dpaa2_eth_set_hash
  staging: fsl-dpaa2/eth: Don't use GFP_DMA
  staging: fsl-dpaa2/eth: Always call napi_gro_receive()
  staging: fsl-dpaa2/eth: Reset dpbp
  staging: fsl-dpaa2/eth: Defer probing if no DPIOs found
  staging: fsl-dpaa2/eth: Update ethtool stats names
  staging: fsl-dpaa2/eth: Add accessor for FAS field
  staging: fsl-dpaa2/eth: Remove unused fields from priv struct
  staging: fsl-dpaa2/eth: Only store bpid in priv struct
  staging: fsl-dpaa2/eth: Reorder priv fields
  staging: fsl-dpaa2/eth: Errors checking update
  staging: fsl-dpaa2/eth: Refactor MAC address setup
  staging: fsl-dpaa2/eth: Update number of netdev queues

 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 228 +++++++++++++--------
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  56 ++---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |  64 +++---
 3 files changed, 204 insertions(+), 144 deletions(-)

-- 
2.11.0
