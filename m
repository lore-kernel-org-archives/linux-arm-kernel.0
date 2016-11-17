From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Thu, 17 Nov 2016 17:46:47 +0530
Subject: [PATCH 0/4] Fixes for Vybrid SPI DMA implementation
In-Reply-To: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
References: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
Message-ID: <cover.1479384571.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following set of patches have fixes for Vybrid SPI DMA
implementation along with some minor clean ups requested
at time when v3 version of SPI DMA support patch was accepted. 

This series of patches is based on top of branch topic/fsl-dspi.
http://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=topic/fsl-dspi

The patches have been tested on a Toradex Colibri Vybrid VF61 module.

Thanks & Regards,
Sanchayan.

Sanchayan Maity (4):
  spi: spi-fsl-dspi: Fix SPI transfer issue when using multiple SPI_IOC_MESSAGE
  spi: spi-fsl-dspi: Fix incorrect DMA setup
  spi: spi-fsl-dspi: Fix continuous selection format
  spi: spi-fsl-dspi: Minor code cleanup and error path fixes

 drivers/spi/spi-fsl-dspi.c | 69 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 18 deletions(-)

-- 
2.10.2
