From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  5 Feb 2013 12:47:41 +0900
Subject: [GIT PULL] Renesas ARM-based SoC for v3.9 #3
Message-ID: <1360036062-3490-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit dc784e73b45dc055f9dcb174ea5753ea020516fc:

  ARM: mach-shmobile: sh73a0: allow unplugging of CPU0 (2013-01-30 13:07:59 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.9

for you to fetch changes up to 58079fa7d54a0929d304054ee759187a2ccd3cdf:

  ARM: shmobile: r8a7779: Correct TMU clock support (2013-02-05 12:31:18 +0900)

----------------------------------------------------------------
Third round of Renesas ARM-based SoC changes for v3.9

A fix for r8a7779 clocks.

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: r8a7779: Correct TMU clock support

 arch/arm/mach-shmobile/clock-r8a7779.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
