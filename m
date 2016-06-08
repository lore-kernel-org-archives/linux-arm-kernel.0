From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 10:00:12 +0900
Subject: [GIT PULL] Renesas ARM Based SoC R-Car SYSC Updates for v4.8
Message-ID: <cover.1465347345.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC R-Car SYSC updates for v4.8.

There are follow-up DT changes that depend on this driver which I hope
will be ready to send to you in the v4.8 development cycle.


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-rcar-sysc-for-v4.8

for you to fetch changes up to e0c98b9171eecf1745eda08de86081db8ec41d51:

  soc: renesas: rcar-sysc: Add support for R-Car M3-W power areas (2016-06-06 10:14:21 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC R-Car SYSC Updates for v4.8

e0c98b9171ee soc: renesas: rcar-sysc: Add support for R-Car M3-W power areas
74699228b99d soc: renesas: Add r8a7796 SYSC PM Domain Binding Definitions
2ff1bf77e4d4 soc: renesas: rcar-sysc: Document r8a7796 support

----------------------------------------------------------------
Geert Uytterhoeven (3):
      soc: renesas: rcar-sysc: Document r8a7796 support
      soc: renesas: Add r8a7796 SYSC PM Domain Binding Definitions
      soc: renesas: rcar-sysc: Add support for R-Car M3-W power areas

 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a7796-sysc.c                 | 48 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 include/dt-bindings/power/r8a7796-sysc.h           | 36 ++++++++++++++++
 6 files changed, 90 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7796-sysc.c
 create mode 100644 include/dt-bindings/power/r8a7796-sysc.h
