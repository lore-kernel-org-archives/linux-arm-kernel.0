From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Thu, 25 Jan 2018 12:51:55 +0530
Subject: [PATCH 0/2] mtd: fsl-quadspi: Update hwcap based on mode provided in
 dtsi file
Message-ID: <1516864917-31969-1-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set added support to update hwcap of FSL QUADSPI controller
by reading values from the device tree files.

Updated the fsl-quadspi binding by adding spi-tx-bus-width,
spi-rx-bus-width binding needed to define mode of operation.

Depends on
 https://patchwork.ozlabs.org/project/linux-mtd/list/?series=25286

Yogesh Gaur (2):
  Documentation: binding: Update fsl-quadspi binding
  mtd: fsl-quadspi: Update hwcap based on mode provided in dtsi file

 .../devicetree/bindings/mtd/fsl-quadspi.txt        |  4 ++
 drivers/mtd/spi-nor/fsl-quadspi.c                  | 46 ++++++++++++++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

-- 
1.9.1
