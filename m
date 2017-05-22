From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:29:58 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.13
Message-ID: <cover.1495454780.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT bindings updates for v4.13.


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.13

for you to fetch changes up to 40c9bbea140e64a4257b794969e759c2c481c399:

  ARM: dts: r7s72100: add USB bit definitions (2017-05-15 09:02:37 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v4.13

* Add USB bit definitions and pinctrl header for r7s72100 SoC
* Add GyroADC clock for r8a7791 SoC

----------------------------------------------------------------
Chris Brandt (1):
      ARM: dts: r7s72100: add USB bit definitions

Jacopo Mondi (1):
      ARM: dts: r7s72100: add Renesas RZ/A1 pinctrl header

Marek Vasut (1):
      ARM: dts: r8a7791: add GyroADC clock

 include/dt-bindings/clock/r7s72100-clock.h     |  2 ++
 include/dt-bindings/clock/r8a7791-clock.h      |  1 +
 include/dt-bindings/pinctrl/r7s72100-pinctrl.h | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/r7s72100-pinctrl.h
