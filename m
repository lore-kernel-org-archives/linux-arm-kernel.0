From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Feb 2013 11:03:20 +0900
Subject: [GIT PULL] Renesas ARM-based SoC for v3.9 #4
Message-ID: <1360116201-9362-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 58079fa7d54a0929d304054ee759187a2ccd3cdf:

  ARM: shmobile: r8a7779: Correct TMU clock support (2013-02-05 12:31:18 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc4-for-v3.9

for you to fetch changes up to dbe1c3defb3844772634446492ea6c13882596ec:

  ARM: shmobile: Register ARM architected timer (2013-02-05 17:13:55 +0900)

----------------------------------------------------------------
Fourth round of Renesas ARM-based SoC changes for v3.9

Register ARM architected timer.

This is preparatory work by Magnus Damm for SoC(s) that use
the ARM architected timer.

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: Register ARM architected timer

 arch/arm/mach-shmobile/timer.c |    3 +++
 1 file changed, 3 insertions(+)
