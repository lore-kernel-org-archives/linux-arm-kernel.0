From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 16 Jan 2017 10:05:58 +0100
Subject: [PATCH 0/2] spi: pca2xx: Prepare for and enable MSI support
Message-ID: <cover.1484557560.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enhances the pca2xx driver's interrupt handler with support for
edge-triggered interrupts and makes use of that for PCI-hosted variants,
like the Intel Quark SoC.

Jan

Jan Kiszka (2):
  spi: pxa2xx: Prepare for edge-triggered interrupts
  spi: pca2xx-pci: Allow MSI

 drivers/spi/spi-pxa2xx-pci.c | 14 +++++++++++--
 drivers/spi/spi-pxa2xx.c     | 50 +++++++++++++++++++++++++-------------------
 2 files changed, 40 insertions(+), 24 deletions(-)

-- 
2.1.4
