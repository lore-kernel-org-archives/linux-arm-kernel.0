From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Aug 2012 09:22:01 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: Core for 3.7
Message-ID: <1346113322-21133-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olaf, Hi Arnd,

please consider the following enhancement for the Renesas ARM-based SoC Core
from Tetsuyuki Kobayashi for inclusion in 3.7.

----------------------------------------------------------------
The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc-core

for you to fetch changes up to e3586c612e3a13118f0dbd2f6e9a4901b1695b81:

  ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs' (2012-08-25 14:38:13 +0900)

----------------------------------------------------------------
Tetsuyuki Kobayashi (1):
      ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs'

 arch/arm/mach-shmobile/Makefile.boot | 4 ++++
 1 file changed, 4 insertions(+)
