From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:44 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.6
Message-ID: <cover.1454595726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.6.


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.6

for you to fetch changes up to a3fc85e27b7e3c29b30909929bc64737a19fd251:

  arm64: dts: salvator-x: Enable SCIF_CLK frequency and pins (2016-02-03 10:04:33 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.6

* Use SCIF fallback compatibility strings
* Add Baud Rate Generator (BRG) support for (H)SCIF
* Enable SCIF_CLK frequency and pins
* Enable USB 3.0 host
* Add Add USB-DMAC device nodes
* Complete SYS-DMAC device nodes

----------------------------------------------------------------
Geert Uytterhoeven (5):
      arm64: dts: r8a7795: Complete SYS-DMAC nodes
      arm64: dts: r8a7795: Add SCIF fallback compatibility strings
      arm64: dts: r8a7795: Rename the serial port clock to fck
      arm64: dts: r8a7795: Add BRG support for (H)SCIF
      arm64: dts: salvator-x: Enable SCIF_CLK frequency and pins

Yoshihiro Shimoda (3):
      arm64: dts: r8a7795: Add USB3.0 host device nodes
      arm64: dts: salvator-x: enable usb3.0 host channel 0
      arm64: dts: r8a7795: Add USB-DMAC device nodes

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  16 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 249 ++++++++++++++++++---
 2 files changed, 229 insertions(+), 36 deletions(-)
