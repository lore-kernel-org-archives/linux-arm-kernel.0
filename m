From: alvin.chen@intel.com (Weike Chen)
Date: Fri, 26 Sep 2014 10:25:48 -0700
Subject: [PATCH] SPI: spi-pxa2xx: Add support for Intel Quark X1000 SPI
 controller
Message-ID: <1411752349-31490-1-git-send-email-alvin.chen@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Intel Quark X1000 consists of two SPI controllers which can be PCI enumerated.
SPI-PXA2XX PCI layer doesn't support it. Thus, we add support for Intel Quark
X1000 SPI as well.

Weike Chen (1):
  SPI: spi-pxa2xx: SPI support for Intel Quark X1000

 drivers/spi/spi-pxa2xx-pci.c |    8 ++
 drivers/spi/spi-pxa2xx.c     |  251 +++++++++++++++++++++++++++++++++++-------
 drivers/spi/spi-pxa2xx.h     |    8 +-
 include/linux/pxa2xx_ssp.h   |   21 ++++
 4 files changed, 249 insertions(+), 39 deletions(-)

-- 
1.7.9.5
