From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Nov 2016 10:24:05 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.10
Message-ID: <cover.1478077617.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC drivers updates for v4.10.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.10

for you to fetch changes up to 603311ba979fa5bbbf6a8961e5f7a27deafce1b4:

  soc: renesas: rcar-sysc: add R8A7743 support (2016-10-17 08:21:20 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Drivers Updates for v4.10

* Add support for the r8a7743 SoC to rcar-sysc

----------------------------------------------------------------
Sergei Shtylyov (2):
      ARM: shmobile: r8a7743: add power domain index macros
      soc: renesas: rcar-sysc: add R8A7743 support

 .../bindings/power/renesas,rcar-sysc.txt           |  7 +++--
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a7743-sysc.c                 | 32 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 include/dt-bindings/power/r8a7743-sysc.h           | 25 +++++++++++++++++
 6 files changed, 66 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/renesas/r8a7743-sysc.c
 create mode 100644 include/dt-bindings/power/r8a7743-sysc.h
