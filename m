From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:40 +0900
Subject: [GIT PULL] Renesas ARM based sh7372 SoC updates for v3.11
Message-ID: <1369645242-3803-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-sh7372-for-v3.11

for you to fetch changes up to 98aaf628f866f530ce6829476e1c2ac98c9c4f60:

  ARM: shmobile: sh7372 pinmux platform device cleanup (2013-05-22 21:46:25 +0900)

----------------------------------------------------------------
Renesas ARM based sh7372 SoC updates for v3.11

* Clean-up from Magnus Damm to use DEFINE_RES_MEM() to slightly reduce code size
* Clean-up from Kuninori Morimoto to remove trailing ; from macros

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: remove ";" from SH_FIXED_RATIO_CLK*() macro

Magnus Damm (1):
      ARM: shmobile: sh7372 pinmux platform device cleanup

 arch/arm/mach-shmobile/include/mach/clock.h |    4 ++--
 arch/arm/mach-shmobile/setup-sh7372.c       |   24 +++++-------------------
 2 files changed, 7 insertions(+), 21 deletions(-)
