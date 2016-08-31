From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  1 Sep 2016 00:21:18 +0200
Subject: [PATCH 0/5] constify ethtool_ops structures
Message-ID: <1472682083-5219-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constify ethtool_ops structures.

---

 drivers/net/ethernet/mediatek/mtk_eth_soc.c       |    2 +-
 drivers/net/ethernet/synopsys/dwc_eth_qos.c       |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    2 +-
 drivers/net/usb/r8152.c                           |    2 +-
 drivers/staging/netlogic/xlr_net.c                |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
