From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:23 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Simple PM Bus Updates for v4.1
Message-ID: <cover.1424931637.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC simple PM bus updates for v4.1.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-simple-pm-bus-for-v4.1

for you to fetch changes up to 89d463ea106dba530786a2815fd174f9e6eab71f:

  drivers: bus: Add Simple Power-Managed Bus Driver (2015-02-24 06:36:18 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Simple PM Bus Updates for v4.1

* Add Simple Power-Managed Bus Driver

----------------------------------------------------------------
Geert Uytterhoeven (5):
      drivers: bus: Sort Kconfig entries alphabetically
      drivers: bus: Sort Makefile entries alphabetically
      drivers: bus: Add Simple Power-Managed Bus DT Bindings
      drivers: bus: Add Renesas Bus State Controller (BSC) DT Bindings
      drivers: bus: Add Simple Power-Managed Bus Driver

 .../devicetree/bindings/bus/renesas,bsc.txt        | 46 +++++++++++++++++
 .../devicetree/bindings/bus/simple-pm-bus.txt      | 44 ++++++++++++++++
 drivers/bus/Kconfig                                | 53 ++++++++++++--------
 drivers/bus/Makefile                               | 15 +++---
 drivers/bus/simple-pm-bus.c                        | 58 ++++++++++++++++++++++
 5 files changed, 189 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/renesas,bsc.txt
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt
 create mode 100644 drivers/bus/simple-pm-bus.c
