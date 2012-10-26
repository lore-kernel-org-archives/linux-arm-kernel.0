From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 26 Oct 2012 11:35:35 +0200
Subject: [GIT PULL] Urgent DMA-mapping fix for v3.7-rc3
Message-ID: <1351244135-12703-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling an urgent fix for ARM DMA-mapping
framework for v3.7-rc3. Due to my mistake, my previous pull request
(merged as cff7b8ba60e332377568c3d55c8036e9b1de32e6) contained a patch
which is aimed for v3.8 and lacks its dependences. This pull request
reverts it and fixes build break of ARM architecture.

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center

----------------------------------------------------------------

The following changes since commit 2ab3f29dddfb444c9fcc0a2f3a56ed4bdba41969:

  Merge branch 'akpm' (Andrew's fixes) (2012-10-25 16:05:57 -0700)

are available in the git repository at:

  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes_for_linus

for you to fetch changes up to 697575896670ba9e76760ce8bbc1f5a3001967d6:

  Revert "ARM: dma-mapping: support debug_dma_mapping_error" (2012-10-26 07:39:13 +0200)

----------------------------------------------------------------
Marek Szyprowski (1):
      Revert "ARM: dma-mapping: support debug_dma_mapping_error"

 arch/arm/include/asm/dma-mapping.h |    1 -
 1 file changed, 1 deletion(-)
