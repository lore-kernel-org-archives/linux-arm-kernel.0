From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 23 Feb 2016 15:23:34 +0530
Subject: [GIT PULL] DaVinci EDMA enhancements for v4.6
In-Reply-To: <1456221214-18042-1-git-send-email-nsekhar@ti.com>
References: <1456221214-18042-1-git-send-email-nsekhar@ti.com>
Message-ID: <1456221214-18042-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.6/edma

for you to fetch changes up to 2137d54d1643c1dcb1ff919f169b4542669a372e:

  ARM: davinci: dm646x: Add dma_slave_map to edma (2016-02-22 15:55:27 +0530)

----------------------------------------------------------------
Pass dma_slave_map data to EDMA driver. This will help
migration to new DMA engine API for requesting
slave channels dma_request_chan().

----------------------------------------------------------------
Peter Ujfalusi (5):
      ARM: davinci: devices-da8xx: Add dma_slave_map to edma
      ARM: davinci: dm355: Add dma_slave_map to edma
      ARM: davinci: dm365: Add dma_slave_map to edma
      ARM: davinci: dm644x: Add dma_slave_map to edma
      ARM: davinci: dm646x: Add dma_slave_map to edma

 arch/arm/mach-davinci/devices-da8xx.c | 46 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c         | 20 +++++++++++++++
 arch/arm/mach-davinci/dm365.c         | 22 +++++++++++++++++
 arch/arm/mach-davinci/dm644x.c        | 12 +++++++++
 arch/arm/mach-davinci/dm646x.c        | 11 +++++++++
 5 files changed, 111 insertions(+)
