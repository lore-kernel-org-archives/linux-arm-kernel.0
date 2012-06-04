From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 Jun 2012 08:31:10 +0200
Subject: [GIT PULL] CMA and ARM DMA-mapping fix for v3.5-rc2
Message-ID: <1338791470-16294-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling a fix for Contiguous Memory Allocator
(CMA) integration for ARM architecture for v3.5-rc2.

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:
  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes-for-linus

Marek Szyprowski (1):
      ARM: dma-mapping: remove unconditional dependency on CMA

 arch/arm/Kconfig          |    1 -
 arch/arm/mm/dma-mapping.c |   10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center
