From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 22 Jul 2012 19:11:02 +0200
Subject: [PATCH net-next 0/4] Tx time stamp advertising for four drivers
Message-ID: <cover.1342976654.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series updates the ethtool code for four drivers that recently
add the skb_tx_timestamp hook. Since these drivers now support
software transmit time stamps, let us also advertise this via ethtool.

Thanks,
Richard

Richard Cochran (4):
  bnx2x: advertise transmit time stamping
  e1000: advertise transmit time stamping
  e1000e: advertise transmit time stamping
  forcedeth: advertise transmit time stamping

 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |    1 +
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |    1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c        |    1 +
 drivers/net/ethernet/nvidia/forcedeth.c            |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.2.5
