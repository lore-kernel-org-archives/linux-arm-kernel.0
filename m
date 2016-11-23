From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:13:10 +0100
Subject: [GIT PULL] Renesas ARM Based SoC r8a7745 SYSC Driver Updates for v4.10
Message-ID: <cover.1479929914.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a7745 SYSC Driver updates for
v4.10.

This pull request is based on v4.9-rc1.

This pull request is broken out of an earlier pull request,
"Second Round of Renesas ARM Based SoC Drivers Updates for v4.10".
The motivation for breaking up the pull request is to provide
branches with minimal dependencies.

This pull request is targeted at the next/drivers branch of the arm-soc tree.

It introduces some minor merge conflicts in:
    Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
    drivers/soc/renesas/Makefile
    drivers/soc/renesas/rcar-sysc.c
    drivers/soc/renesas/rcar-sysc.h
The resolution is to take both sides. A sample merge resolution is
provided in the renesas-next-20161123v2-v4.9-rc1 tag of the renesas tree.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a7745-sysc-for-v4.10

for you to fetch changes up to 141723e0cbdc1139410f77d8a572f17ce2de6bf5:

  soc: renesas: rcar-sysc: add R8A7745 support (2016-11-23 14:28:41 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC r8a7745 SYSC Driver Updates for v4.10

* Add support for the r8a7745 SoC to rcar-sysc

----------------------------------------------------------------
Sergei Shtylyov (2):
      ARM: shmobile: r8a7745: add power domain index macros
      soc: renesas: rcar-sysc: add R8A7745 support

 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a7745-sysc.c                 | 32 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 include/dt-bindings/power/r8a7745-sysc.h           | 25 +++++++++++++++++
 6 files changed, 63 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7745-sysc.c
 create mode 100644 include/dt-bindings/power/r8a7745-sysc.h
