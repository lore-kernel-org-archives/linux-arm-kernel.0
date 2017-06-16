From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:30 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.13
Message-ID: <cover.1497617480.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC drivers updates for v4.13.

This pull request is based on
"[GIT PULL] Renesas ARM Based SoC Fixes for v4.12",
tagged as renesas-fixes-for-v4.12,
which you have already pulled and is present in v4.12-rc2.

This base was used to supply a dependency. It is one patch away from
v4.11-rc1.  I could also have based the series on v4.12-rc2 but I wanted to
avoid basing (any of my branches for v4.13) on something more recent than
v4.12-rc1 unless strictly necessary. Nonetheless I'm happy to rebase if you
prefer.


The following changes since commit 7b4ccb3c466f62bbf2f4dd5d6a143d945a6f3051:

  soc: renesas: Provide dummy rcar_rst_read_mode_pins() for compile-testing (2017-04-28 10:07:36 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.13

for you to fetch changes up to 8be381a131c29c4737aed44e7e5f90cb77bb4a7e:

  soc: renesas: Rework Kconfig and Makefile logic (2017-06-12 11:31:07 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Drivers Updates for v4.13

* Rework Kconfig and Makefile logic

----------------------------------------------------------------
Geert Uytterhoeven (1):
      soc: renesas: Rework Kconfig and Makefile logic

 drivers/soc/Kconfig                  |  1 +
 drivers/soc/Makefile                 |  2 +-
 drivers/soc/renesas/Kconfig          | 63 ++++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/Makefile         | 31 +++++++++---------
 drivers/soc/renesas/rcar-sysc.c      | 24 +++++++-------
 include/linux/soc/renesas/rcar-rst.h |  3 +-
 6 files changed, 92 insertions(+), 32 deletions(-)
 create mode 100644 drivers/soc/renesas/Kconfig
