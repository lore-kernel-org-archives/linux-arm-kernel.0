From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Apr 2016 13:44:48 +1000
Subject: [GIT PULL] Renesas ARM Based SoC R-Car SYSC Updates for v4.7
Message-ID: <cover.1461210185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC R-Car SYSC updates for v4.7.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-rcar-sysc-for-v4.7

for you to fetch changes up to 839a04d847f5871516f500091519c52dc40fe01d:

  soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions (2016-04-15 11:01:58 +1000)

----------------------------------------------------------------
Renesas ARM Based SoC R-Car SYSC Updates for v4.7

* Add DT bindings for the R-Car System Controller.
  An implementation is intended to follow.

----------------------------------------------------------------
Geert Uytterhoeven (7):
      PM / Domains: Add DT bindings for the R-Car System Controller
      soc: renesas: Add r8a7779 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7790 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7791 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7794 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions

 .../bindings/power/renesas,rcar-sysc.txt           | 48 ++++++++++++++++++++++
 include/dt-bindings/power/r8a7779-sysc.h           | 27 ++++++++++++
 include/dt-bindings/power/r8a7790-sysc.h           | 34 +++++++++++++++
 include/dt-bindings/power/r8a7791-sysc.h           | 26 ++++++++++++
 include/dt-bindings/power/r8a7793-sysc.h           | 28 +++++++++++++
 include/dt-bindings/power/r8a7794-sysc.h           | 26 ++++++++++++
 include/dt-bindings/power/r8a7795-sysc.h           | 42 +++++++++++++++++++
 7 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
 create mode 100644 include/dt-bindings/power/r8a7779-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7790-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7791-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7793-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7794-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7795-sysc.h
