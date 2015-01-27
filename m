From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 27 Jan 2015 16:30:28 +0100
Subject: [RESEND PATCH v2 0/4] dmaengine: at_xdmac: several improvements
Message-ID: <1422372632-21659-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is based on vkoul/slave-dma/topic/slave_caps_device_control_fix
branch.

Changes from v1:
- put save_cc field addition in a single patch
- update commit log of patch 3/4
- remove AT_XDMAC_CUR_CFG since it is no more used

Cyrille Pitchen (1):
  dmaengine: at_xdmac: wait for in-progress transaction to complete
    after pausing a channel

Ludovic Desroches (3):
  dmaengine: at_xdmac: introduce save_cc field
  dmaengine: at_xdmac: simplify channel configuration stuff
  dmaengine: at_xdmac: allow muliple dwidths when doing slave transfers

 drivers/dma/at_xdmac.c | 60 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

-- 
2.2.0
