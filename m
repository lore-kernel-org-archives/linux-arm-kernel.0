From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 15:54:04 +0900
Subject: [GIT PULL v2 0/1] Renesas ARM based SoC cleanups for v3.11
Message-ID: <1371452045-21959-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This small pull request is based on a merge of
renesas-soc-for-v3.11 and renesas-pinmux-for-v3.11 both
of which you have previously pulled. The reason for this base is to provide
all the code that the one patch in this request adds annotations to.

The following changes since commit 12dd9752512449f0336b7d64df3871145a28a2fe:

  Merge tags 'renesas-pinmux-for-v3.11' and 'renesas-soc-for-v3.11' into cleanup (2013-06-13 14:45:20 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.11

for you to fetch changes up to f9094c526bca3cc50ef7d409c22976fa0f47bbba:

  ARM: shmobile: r8a7790: add __initdata on resource and device data (2013-06-13 14:47:34 +0900)

----------------------------------------------------------------
Renesas ARM based SoC cleanups for v3.11

__initdata annotations for the r8a7790 SoC by Morimoto-san.

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: r8a7790: add __initdata on resource and device data

 arch/arm/mach-shmobile/setup-r8a7790.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
