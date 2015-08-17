From: isubramanian@apm.com (Iyappan Subramanian)
Date: Mon, 17 Aug 2015 14:33:03 -0700
Subject: [PATCH v1 0/2] drivers: net: xgene: Add TSO support
Message-ID: <1439847185-22046-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding TSO support

iperf Tx data rate without TSO: 3.42 Gbps
                      with TSO: 9.41 Gbps

v1
* Initial version

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (2):
  drivers: net: xgene: Preparatory patch for TSO support
  drivers: net: xgene: Adding support for TSO

 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h    |  16 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c  | 260 ++++++++++++++++++++--
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h  |  12 +
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c |   8 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.h |   2 +
 5 files changed, 272 insertions(+), 26 deletions(-)

-- 
1.9.1
