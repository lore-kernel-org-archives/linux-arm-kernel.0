From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Oct 2012 15:49:19 +0900
Subject: [GIT PULL] Renesas ARM-based SoC fixes for v3.7 #2
Message-ID: <1350629360-27438-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following fix for the r8a7779 SoC for 3.6.
It resolves some more fallout from recent IOMEM() changes.

----------------------------------------------------------------
The following changes since commit 11f93576b0b50bf391ffafa544b85e541f5e59a5:

  ARM: shmobile: r8a7779: use __iomem pointers for MMIO (2012-10-16 08:58:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git fixes

for you to fetch changes up to ed7d132a634e7e4c3fa657363df5df39e7f768e4:

  ARM: shmobile: r8a7779: I/O address abuse cleanup (2012-10-19 15:39:38 +0900)

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: r8a7779: I/O address abuse cleanup

 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
