From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 14:14:07 -0400
Subject: [GIT PULL] Renesas ARM Based SoC Sysc Updates for v4.12
Message-ID: <cover.1491588035.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC sysc updates for v4.12.

This pull request is based on the soc-device-match-tag2 tag of
Geert Uytterhoeven's renesas-drivers tree which he has already
sent a pull-request for.


The following changes since commit 6e12db376b60b7158e4e6006af60566f8c68f7ab:

  base: soc: Allow early registration of a single SoC device (2017-03-29 21:43:26 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sysc-for-v4.12

for you to fetch changes up to fcb87087261e1be51b4c03677f39246bdc312b1c:

  soc: renesas: rcar-sysc: Add support for R-Car H3 ES2.0 (2017-04-07 13:53:41 -0400)

----------------------------------------------------------------
Renesas ARM Based SoC Sysc Updates for v4.12

* Add support for R-Car H3 ES2.0

----------------------------------------------------------------
Geert Uytterhoeven (3):
      soc: renesas: Register SoC device early
      soc: renesas: rcar-sysc: Add support for fixing up power area tables
      soc: renesas: rcar-sysc: Add support for R-Car H3 ES2.0

 drivers/soc/renesas/r8a7795-sysc.c       | 26 ++++++++++++++++++++++++--
 drivers/soc/renesas/rcar-sysc.c          | 25 ++++++++++++++++++++++++-
 drivers/soc/renesas/rcar-sysc.h          | 10 ++++++++++
 drivers/soc/renesas/renesas-soc.c        |  2 +-
 include/dt-bindings/power/r8a7795-sysc.h |  2 +-
 5 files changed, 60 insertions(+), 5 deletions(-)
