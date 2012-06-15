From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 15 Jun 2012 07:54:24 +0200
Subject: [GIT PULL] DMA-mapping fixes for v3.5-rc3
Message-ID: <1339739664-31736-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling a set of minor fixes for dma-mapping
code (ARM and x86) required for Contiguous Memory Allocator (CMA)
patches merged in v3.5-rc1.

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

with the top-most commit c080e26edc3a2a3cdfa4c430c663ee1c3bbd8fae

  x86: dma-mapping: fix broken allocation when dma_mask has been provided

are available in the git repository at:
  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes-for-linus

Marek Szyprowski (3):
      ARM: mm: fix type of the arm_dma_limit global variable
      ARM: dma-mapping: fix debug messages in dmabounce code
      x86: dma-mapping: fix broken allocation when dma_mask has been provided

Sachin Kamat (1):
      ARM: dma-mapping: Add missing static storage class specifier

 arch/arm/common/dmabounce.c |   16 ++++++++--------
 arch/arm/mm/dma-mapping.c   |    4 ++--
 arch/arm/mm/init.c          |    2 +-
 arch/arm/mm/mm.h            |    2 +-
 arch/x86/kernel/pci-dma.c   |    3 ++-
 5 files changed, 14 insertions(+), 13 deletions(-)

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center
