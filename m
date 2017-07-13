From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Fri, 14 Jul 2017 00:34:06 +0530
Subject: [PATCH 0/3] Extend BGMAC driver for Stingray SoC
Message-ID: <1499972649-6200-1-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset extends Broadcom BGMAC driver for Broadcom Stingray SoC.

This patchset is based on Linux-4.12 and tested on NS2 and Stingray.

Abhishek Shah (3):
  net: ethernet: bgmac: Remove unnecessary 'return' from
    platform_bgmac_idm_write
  net: ethernet: bgmac: Make IDM register space optional in BGMAC driver
  Documentation: devicetree: net: optional idm regs for bgmac

 .../devicetree/bindings/net/brcm,amac.txt          |  1 +
 drivers/net/ethernet/broadcom/bgmac-platform.c     | 21 ++++---
 drivers/net/ethernet/broadcom/bgmac.c              | 70 +++++++++++++---------
 drivers/net/ethernet/broadcom/bgmac.h              |  1 +
 4 files changed, 57 insertions(+), 36 deletions(-)

-- 
2.7.4
