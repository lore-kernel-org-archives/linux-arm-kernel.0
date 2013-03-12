From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Mar 2013 18:58:52 +0530
Subject: [GIT PULL] DaVinci fixes for v3.9-rc
Message-ID: <513F2D94.8030706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following fix for v3.9-rc?

Thanks,
Sekhar

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.9-rc/fixes

for you to fetch changes up to 069552777a121eb39da29de4bc0383483dbe1f7e:

  ARM: davinci: edma: fix dmaengine induced null pointer dereference on da830 (2013-03-12 17:10:46 +0530)

----------------------------------------------------------------
This patch fixes a boot breakage on DA830
that was introduced with EDMA DMA engine
conversion. The bug has been there since
v3.7 and has been marked for stable update.

----------------------------------------------------------------
Matt Porter (1):
      ARM: davinci: edma: fix dmaengine induced null pointer dereference on da830

 arch/arm/mach-davinci/dma.c |    3 +++
 1 file changed, 3 insertions(+)
