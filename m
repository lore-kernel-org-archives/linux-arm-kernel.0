From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 12:05:15 +0530
Subject: [PATCH 0/4] emaclite bug fixes and code cleanup
Message-ID: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes bug in emaclite remove and mdio_setup routines.
It does minor code cleanup.

Radhey Shyam Pandey (4):
  net: emaclite: Fix position of lp->mii_bus assignment
  net: emaclite: Fix MDIO bus unregister bug
  net: emaclite: Remove unused 'has_mdio' flag.
  net: emaclite: Remove xemaclite_mdio_setup return check

 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)
