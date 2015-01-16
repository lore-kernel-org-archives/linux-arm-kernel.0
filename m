From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:06 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v3.20
Message-ID: <cover.1421371868.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC drivers updates for v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v3.20

for you to fetch changes up to ab9ff6fe6fdd225a92ae740eceb05e12daf00ce1:

  drivers: bus: Add Simple Power-Managed Bus Driver (2015-01-14 09:38:24 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Drivers Updates for v3.20

* Add Simple Power-Managed Bus

----------------------------------------------------------------
Geert Uytterhoeven (4):
      drivers: bus: Sort Kconfig entries alphabetically
      drivers: bus: Sort Makefile entries alphabetically
      drivers: bus: Add Simple Power-Managed Bus DT Bindings
      drivers: bus: Add Simple Power-Managed Bus Driver

 .../devicetree/bindings/bus/simple-pm-bus.txt      | 52 +++++++++++++++++++++
 drivers/bus/Kconfig                                | 53 ++++++++++++++--------
 drivers/bus/Makefile                               | 15 +++---
 drivers/bus/simple-pm-bus.c                        | 51 +++++++++++++++++++++
 4 files changed, 144 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt
 create mode 100644 drivers/bus/simple-pm-bus.c
