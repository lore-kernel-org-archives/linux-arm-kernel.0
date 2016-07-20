From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 20 Jul 2016 14:53:49 -0700
Subject: [PATCH v2 0/2] Add big endian and ONFI support to iProc NAND
Message-ID: <1469051631-7896-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds big endian and ONFI support to iProc based NAND wrapper
that utilizes the BRCMSTB NAND core driver. It also adds missing NAND DT
properties for NS2 SVK

This patch series is based off v4.7-rc1 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: iproc-nand-be-v2

Changes from v1:
 - Fixed minor format by adding braces around the 'else'

Ray Jui (2):
  mtd: brcmnand: iProc big endian and ONFI support
  arm64: dts: Updated NAND DT properties for NS2 SVK

 arch/arm64/boot/dts/broadcom/ns2-svk.dts |  2 ++
 drivers/mtd/nand/brcmnand/brcmnand.c     | 12 ++++++------
 drivers/mtd/nand/brcmnand/brcmnand.h     | 13 ++++++++-----
 drivers/mtd/nand/brcmnand/iproc_nand.c   | 18 ++++++++++++++----
 4 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.1.4
