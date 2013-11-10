From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Nov 2013 11:53:09 +0100
Subject: [GIT PULL] Allwinner sunXi clock patches for 3.13
Message-ID: <20131110105309.GA16835@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Emilio doesn't have time to send the pull request for this release
cycle, so I'm doing the pull request for this merge window. The
current plan is that he'll do the next ones.

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-clk-for-3.13

for you to fetch changes up to e71c69fc3362b88b09194d486dda6d721a8004f6:

  drivers: clk: sunxi: Fix memory leakage in clk-sunxi.c (2013-11-10 11:40:51 +0100)

----------------------------------------------------------------
Allwinner sunXi SoCs clock changes

Those are mostly random fixes, except for one patch to the composite
clock that adds support for automatic reparenting.

----------------------------------------------------------------
Emilio L?pez (4):
      clk: composite: .determine_rate support
      clk: sunxi: factors: fix off-by-one masks
      clk: sunxi: factors: clear variables before using them
      clk: sunxi: protect core clocks from accidental shutdown

Victor N. Ramos Mello (1):
      drivers: clk: sunxi: Fix memory leakage in clk-sunxi.c

 drivers/clk/clk-composite.c     | 28 +++++++++++++++++++++
 drivers/clk/sunxi/clk-factors.c |  4 +--
 drivers/clk/sunxi/clk-sunxi.c   | 56 +++++++++++++++++++++++++++++++++--------
 3 files changed, 75 insertions(+), 13 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131110/611de733/attachment-0001.sig>
