From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue, 21 Mar 2017 12:24:39 -0700
Subject: [PATCH net-next 0/4] drivers: net: xgene-v2: Add MDIO and ethtool
 support
Message-ID: <1490124283-10371-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set,
    
- adds phy management and ethtool support
- fixes ethernet reset
- addresses review comments from previous patch set

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (4):
  drivers: net: xgene-v2: Add MDIO support
  drivers: net: xgene-v2: Add ethtool support
  drivers: net: xgene-v2: Fix port reset
  drivers: net: xgene-v2: misc fixes

 drivers/net/ethernet/apm/xgene-v2/Makefile  |   2 +-
 drivers/net/ethernet/apm/xgene-v2/enet.c    |  24 +++-
 drivers/net/ethernet/apm/xgene-v2/enet.h    |   2 +
 drivers/net/ethernet/apm/xgene-v2/ethtool.c | 121 +++++++++++++++++++
 drivers/net/ethernet/apm/xgene-v2/mac.c     |   2 +-
 drivers/net/ethernet/apm/xgene-v2/mac.h     |   2 +-
 drivers/net/ethernet/apm/xgene-v2/main.c    |  69 ++++++-----
 drivers/net/ethernet/apm/xgene-v2/main.h    |   6 +
 drivers/net/ethernet/apm/xgene-v2/mdio.c    | 178 ++++++++++++++++++++++++++++
 9 files changed, 365 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/ethernet/apm/xgene-v2/ethtool.c
 create mode 100644 drivers/net/ethernet/apm/xgene-v2/mdio.c

-- 
1.9.1
