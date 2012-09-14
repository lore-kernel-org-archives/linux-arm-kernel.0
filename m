From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 Sep 2012 17:48:45 +0200
Subject: [GIT PULL] One more DMA-mapping fix for v3.6
Message-ID: <1347637725-8300-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling one more patch for ARM dma-mapping
subsystem to Linux v3.6 kernel tree. This patch fixes very subtle bug
(typical off-by-one error) which might appear in very rare
circumstances. 

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at: 

  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes-for-3.6

for you to fetch changes up to f3d87524975f01b885fc3d009c6ab6afd0d00746:

  arm: mm: fix DMA pool affiliation check (2012-09-10 16:15:48 +0200)

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center

Patch summary:
----------------------------------------------------------------
Thomas Petazzoni (1):
      arm: mm: fix DMA pool affiliation check

 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
