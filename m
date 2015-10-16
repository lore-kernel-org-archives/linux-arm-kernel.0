From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 16 Oct 2015 13:35:50 -0700
Subject: [PATCH net-next 0/2] drivers: xgene: Add support RGMII TX/RX delay
 configuration
Message-ID: <1445027752-16982-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support RGMII TX/RX delay configuration.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (2):
  drivers: net: xgene: Add support RGMII TX/RX delay configuration
  Documentation: dts: xgene: Add TX/RX delay field

 .../devicetree/bindings/net/apm-xgene-enet.txt     | 10 +++++
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |  8 +++-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   | 49 ++++++++++++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  2 +
 5 files changed, 69 insertions(+), 1 deletion(-)

-- 
1.9.1
