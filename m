From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 27 Sep 2012 10:01:20 +0200
Subject: [GIT PULL] DMA-mapping fix for v3.6
Message-ID: <1348732880-7141-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling yet another patch for ARM dma-mapping
subsystem to Linux v3.6 kernel tree. This patch fixes potential memory
leak ARM dma-mapping code.

The following changes since commit 979570e02981d4a8fc20b3cc8fd651856c98ee9d:

  Linux 3.6-rc7 (2012-09-23 18:10:57 -0700)

are available in the git repository at:

  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes-for-3.6

for you to fetch changes up to ec10665cbf271fb1f60daeb194ad4f2cdcdc59d9:

  ARM: dma-mapping: Fix potential memory leak in atomic_pool_init() (2012-09-24 08:35:03 +0200)

----------------------------------------------------------------
Sachin Kamat (1):
      ARM: dma-mapping: Fix potential memory leak in atomic_pool_init()

 arch/arm/mm/dma-mapping.c |    2 ++
 1 file changed, 2 insertions(+)
