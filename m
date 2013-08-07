From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:30:17 +0900
Subject: [GIT PULL 0/3] Second round of Renesas ARM-based SoC board updates
 for v3.12
Message-ID: <cover.1375839719.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM-based SoC board updates
for v3.12.

This pull-request is based on renesas-boards-for-v3.12, which I have
previously sent a pull-request for.


The following changes since commit f79d68da510bf1b95beff4d556b78d06801f11dc:

  ARM: shmobile: ape6evm: add SDHI interfaces (2013-07-25 14:46:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.12

for you to fetch changes up to 4901e136aa5c35873701156c4c0af5b3c2c8faee:

  ARM: shmobile: lager: enable Ether (2013-08-06 18:18:53 +0900)

----------------------------------------------------------------
Second round of Renesas ARM-based SoC board updates for v3.12

* Enable ether on lager board
* Enable GPIO LEDs and switches on ape6evm board

----------------------------------------------------------------
Simon Horman (3):
      ARM: shmobile: ape6evm: support GPIO switches
      ARM: shmobile: ape6evm: Add GPIO LEDs
      ARM: shmobile: lager: enable Ether

 arch/arm/mach-shmobile/board-ape6evm.c | 60 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager.c   | 29 ++++++++++++++++
 2 files changed, 89 insertions(+)
