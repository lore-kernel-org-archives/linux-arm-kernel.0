From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:58 +0900
Subject: [GIT PULL] Renesas ARM Based SoC sh73a0 CCF Updates for v3.20
Message-ID: <cover.1419809955.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC sh73a0 CCF updates for v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-ccf-for-v3.20

for you to fetch changes up to 09bd745b555c262d1e2c851777317f3adf3cf3d4:

  ARM: shmobile: sh73a0: disable legacy clock initialization (2014-12-21 17:09:25 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC sh73a0 CCF Updates for v3.20

* Add sh73a0 CCF support

----------------------------------------------------------------
Ulrich Hecht (6):
      clk: shmobile: sh73a0 common clock framework implementation
      ARM: shmobile: sh73a0: Add CPG register bits header
      ARM: shmobile: sh73a0: Common clock framework DT description
      ARM: shmobile: kzm9g-reference: Common clock framework DT description
      ARM: shmobile: sh73a0: add MSTP clock assignments to DT
      ARM: shmobile: sh73a0: disable legacy clock initialization

 .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  35 ++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   4 +
 arch/arm/boot/dts/sh73a0.dtsi                      | 358 +++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c              |   5 +-
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-sh73a0.c                  | 218 +++++++++++++
 include/dt-bindings/clock/sh73a0-clock.h           |  79 +++++
 7 files changed, 699 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-sh73a0.c
 create mode 100644 include/dt-bindings/clock/sh73a0-clock.h
