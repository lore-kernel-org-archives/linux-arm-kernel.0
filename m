From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:31:08 +0200
Subject: [GIT PULL] Renesas ARM Based SoC R-Car SYSC Updates for v4.13
Message-ID: <cover.1497619041.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC R-Car SYSC updates for v4.13.

This has been separated out from the pull request
"[GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.13"
due to differing dependencies. It seems cleanest to provide separate
branchs rather than do a merge to create a common base for a single branch.


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-rcar-sysc-for-v4.13

for you to fetch changes up to 980532a5dda319eeafadc5c590376626ad178f4f:

  soc: renesas: rcar-sysc: Use GENPD_FLAG_ALWAYS_ON (2017-06-15 21:10:41 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC R-Car SYSC Updates for v4.13

Use GENPD_FLAG_ALWAYS_ON in R-Car SYSC driver

----------------------------------------------------------------
Geert Uytterhoeven (1):
      soc: renesas: rcar-sysc: Use GENPD_FLAG_ALWAYS_ON

 drivers/soc/renesas/rcar-sysc.c | 28 ++++------------------------
 drivers/soc/renesas/rcar-sysc.h |  2 --
 2 files changed, 4 insertions(+), 26 deletions(-)
