From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 25 Aug 2011 11:13:30 +0900
Subject: To use DMA generic APIs for Samsung DMA
Message-ID: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from V7 are following:
- [PATCH v7 03/15]: Change commit message
- [PATCH v7 04/15]: Change the data type of 'cyclic' variable from 'enum'
  to 'bool'. It removes the redundant status.
- [PATCH v7 05/15]: Change the build configuration name of samsung DMA from
  'SAMSUNG_DMA_PL330' to 'SAMSUNG_DMADEV' in order to remove the PL330
  dependency on it.

[PATCH v7 01/15] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH v7 02/15] DMA: PL330: Update PL330 DMA API driver
[PATCH v7 03/15] DMA: PL330: Modify device_control()
[PATCH v7 04/15] DMA: PL330: Add DMA_CYCLIC capability
[PATCH v7 05/15] ARM: SAMSUNG: Update to use PL330-DMA driver
[PATCH v7 06/15] ARM: SAMSUNG: Add common DMA operations
[PATCH v7 07/15] ARM: EXYNOS4: Use generic DMA PL330 driver
[PATCH v7 08/15] ARM: S5PV210: Use generic DMA PL330 driver
[PATCH v7 09/15] ARM: S5PC100: Use generic DMA PL330 driver
[PATCH v7 10/15] ARM: S5P64X0: Use generic DMA PL330 driver
[PATCH v7 11/15] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
[PATCH v7 12/15] spi/s3c64xx: Add support DMA engine API
[PATCH v7 13/15] spi/s3c64xx: Merge dma control code
[PATCH v7 14/15] ASoC: Samsung: Update DMA interface
[PATCH v7 15/15] ARM: SAMSUNG: Remove Samsung specific enum type for dma direction
