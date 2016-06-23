From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Thu, 23 Jun 2016 11:24:16 +0530
Subject: [PATCH 0/2] net: thunderx: Miscellaneous fixes
Message-ID: <1466661258-349-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This 2 patch series fixes issues w.r.t physical link status 
reporting and transmit datapath configuration for 
secondary qsets.

Sunil Goutham (2):
  net: thunderx: Fix link status reporting
  net: thunderx: Fix TL4 configuration for secondary Qsets

 drivers/net/ethernet/cavium/thunder/nic_main.c    | 16 ++++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 86 +++++++++++++++--------
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  2 +
 3 files changed, 70 insertions(+), 34 deletions(-)

-- 
2.7.4
