From: joe@perches.com (Joe Perches)
Date: Wed, 12 Mar 2014 10:22:29 -0700
Subject: [PATCH net-next 0/9] drivers/net: Convert uses of __constant_<foo> to
 <foo>
Message-ID: <cover.1394644825.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches (9):
  brocade: Convert uses of __constant_<foo> to <foo>
  e100: Convert uses of __constant_<foo> to <foo>
  igb: Convert uses of __constant_<foo> to <foo>
  igbvf: Convert uses of __constant_<foo> to <foo>
  ixgbe: Convert uses of __constant_<foo> to <foo>
  ixgbevf: Convert uses of __constant_<foo> to <foo>
  xilinx: Convert uses of __constant_<foo> to <foo>
  lg-vl600: Convert uses of __constant_<foo> to <foo>
  ath9k: Convert uses of __constant_<foo> to <foo>

 drivers/net/ethernet/brocade/bna/bnad.c           | 16 +++++-------
 drivers/net/ethernet/intel/e100.c                 |  4 +--
 drivers/net/ethernet/intel/igb/igb_main.c         | 12 ++++-----
 drivers/net/ethernet/intel/igbvf/netdev.c         |  4 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c     |  8 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 30 +++++++++++------------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 +--
 drivers/net/ethernet/xilinx/ll_temac_main.c       |  4 +--
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |  2 +-
 drivers/net/usb/lg-vl600.c                        |  2 +-
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c    |  4 +--
 11 files changed, 43 insertions(+), 47 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty
