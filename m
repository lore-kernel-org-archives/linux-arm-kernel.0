From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:32:11 +0900
Subject: [PATCH 0/2] [GIT PULL] Renesas ARM-based 'SoC2' for v3.8 #3
Message-ID: <1352446333-20082-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following SoC enhancements for 3.8.

* This pull-request is based on the boards branch of the rensas tree
  which I have sent a pull-request for. The boards branch is in
  turn based on the soc branch. The reason for the soc2 -> boards -> soc
  branch progression is to satisfy dependencies of patches in
  the boards and soc branches.

----------------------------------------------------------------
The following changes since commit 12818d82ccad9868a820dbb193b4f9b797cd02d4:

  ARM: shmobile: use FSI driver's audio clock on ap4evb (2012-11-08 17:52:05 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc2

for you to fetch changes up to d5b689089d7db3851c4d5d6b3727d22ef44d2023:

  ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global (2012-11-08 17:52:35 +0900)

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: sh7372: remove fsidivx clock
      ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global

 arch/arm/mach-shmobile/clock-sh7372.c        |   20 ++++++++++----------
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 --
 2 files changed, 10 insertions(+), 12 deletions(-)
