From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Mon, 27 Jun 2016 15:30:01 +0530
Subject: [PATCH v2 0/2] net: thunderx: Miscellaneous fixes
Message-ID: <1467021603-26226-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This 2 patch series fixes issues w.r.t physical link status
reporting and transmit datapath configuration for
secondary qsets.

Changes from v1:
Fixed lmac disable sequence for interfaces of type SGMII.

Sunil Goutham (2):
  net: thunderx: Fix link status reporting
  net: thunderx: Fix TL4 configuration for secondary Qsets

 drivers/net/ethernet/cavium/thunder/nic_main.c    | 16 +++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 91 +++++++++++++++--------
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  2 +
 3 files changed, 75 insertions(+), 34 deletions(-)

-- 
2.7.4
