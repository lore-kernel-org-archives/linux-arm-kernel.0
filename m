From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 09 Aug 2012 07:53:25 +0200
Subject: [GIT PULL] DMA-mapping fixups for v3.6-rc2
Message-ID: <1344491605-19770-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling a set of fixup patches for ARM
dma-mapping extensions merged in v3.6-rc1.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

with the top-most commit d9e0d149b5dcc2ef4688afc572b9906bcda941ef

  ARM: dma-mapping: fix incorrect freeing of atomic allocations

are available in the git repository at:

  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes-for-linus-for-3.6-rc2

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Aaro Koskinen (2):
      ARM: dma-mapping: fix atomic allocation alignment
      ARM: dma-mapping: fix incorrect freeing of atomic allocations

Chris Brand (1):
      ARM: mm: fix MMU mapping of CMA regions

 arch/arm/mm/dma-mapping.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
