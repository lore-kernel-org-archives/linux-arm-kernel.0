From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:32 +0900
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for v4.5
Message-ID: <cover.1448587800.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates
for v4.5.

This pull request enables GPIO, EthernetAVB, I2C and Sound on
r8a7795/salvator-x.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.5,
which I have already sent a pull-request for.


The following changes since commit b138e11931f2fe25cf188ed62b54bc36f59a25ce:

  MAINTAINERS: Add entry for Renesas arm64 architecture (2015-11-17 02:55:03 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.5

for you to fetch changes up to 672b79312c04016481a11d4b996b4512207ffbd3:

  arm64: renesas: salvator-x: Sound DVC support (2015-11-26 11:31:43 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.5

* Enable GPIO, EthernetAVB, I2C and Sound on r8a7795/salvator-x

----------------------------------------------------------------
Geert Uytterhoeven (2):
      arm64: renesas: salvator-x: Setup ethernet0 alias for U-Boot
      arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes

Kazuya Mizuguchi (2):
      arm64: dts: r8a7795: add EthernetAVB device node
      arm64: dts: r8a7795: enable EthernetAVB on Salvator-X

Kuninori Morimoto (12):
      arm64: renesas: r8a7795: add I2C support
      arm64: renesas: salvator-x: enable I2C
      arm64: renesas: r8a7795: add AUDIO_DMAC support
      arm64: renesas: r8a7795: Sound SSI PIO support
      arm64: renesas: r8a7795: Sound SSI DMA support
      arm64: renesas: r8a7795: Sound SRC support
      arm64: renesas: r8a7795: Sound DVC support
      arm64: renesas: salvator-x: Sound SSI PIO support
      arm64: renesas: salvator-x: Sound SSI DMA support
      arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
      arm64: renesas: salvator-x: Sound SRC support
      arm64: renesas: salvator-x: Sound DVC support

Simon Horman (1):
      arm64: dts: r8a7795: enable nfs root on Salvator-X board

Takeshi Kihara (1):
      arm64: dts: r8a7795: add GPIO nodes

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 140 +++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 554 +++++++++++++++++++++
 2 files changed, 693 insertions(+), 1 deletion(-)
