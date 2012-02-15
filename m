From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:31:30 +0900
Subject: [PATCH v2 0/3] ARM: EXYNOS: add support mdma and EXYNOS4X12 dma
Message-ID: <1329345093-16180-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support enabling mdma driver and dma for EXYNOS4X12.
Basically, not changed but rebased on arm-soc/depends/rmk/for-armsoc
and merged next/cleanup-exynos-clock-v2 and next/cleanup-use-static.

[PATCH v2 1/3] ARM: EXYNOS: Enable MDMA driver
[PATCH RE-SEND 2/3] ARM: EXYNOS: Add apb_pclk clkdev entry for mdma1
[PATCH v2 3/3] ARM: EXYNOS: add support DMA for EXYNOS4X12 SoC
