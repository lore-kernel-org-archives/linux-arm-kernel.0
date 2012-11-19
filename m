From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 10:24:13 +0900
Subject: [GIT PULL] Renesas ARM-based SoC boards for v3.8 #3
Message-ID: <1353288254-6211-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please consider the following board fix for 3.8.

Also, please let me know if you would prefer me to supply
this as a fixes branch as we are now in the 3.7-rc6 timeframe
where I understand that non-fix commits are no longer allowed for 3.8.

This commit is based on the renesas/boards2 branch of the arm-soc tree.

----------------------------------------------------------------
The following changes since commit 12818d82ccad9868a820dbb193b4f9b797cd02d4:

  ARM: shmobile: use FSI driver's audio clock on ap4evb (2012-11-08 17:52:05 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards3

for you to fetch changes up to d01f4b82fbee516b4d3f03b086333fc4a127983c:

  ARM: shmobile: mackerel: Add FLCTL IRQ resource (2012-11-19 10:08:20 +0900)

----------------------------------------------------------------
Bastian Hecht (1):
      ARM: shmobile: mackerel: Add FLCTL IRQ resource

 arch/arm/mach-shmobile/board-mackerel.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
