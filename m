From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Jun 2017 11:27:22 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v4.12
Message-ID: <cover.1497259417.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC fixes for v4.12.

It splits LCD mux and gpio into separate nodes as different values
for the output-high property are required.

This pull request is based on the previous round of
such requests, tagged as renesas-fixes-for-v4.12,
which I have already sent a pull-request for.


The following changes since commit 7b4ccb3c466f62bbf2f4dd5d6a143d945a6f3051:

  soc: renesas: Provide dummy rcar_rst_read_mode_pins() for compile-testing (2017-04-28 10:07:36 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v4.12

for you to fetch changes up to 13132b3f44d3600983aceb7e9920b8ebb55a7cf8:

  ARM: dts: armadillo800eva: Split LCD mux and gpio (2017-06-08 15:44:55 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Fixes for v4.12

* Split LCD mux and gpio on armadillo800eva board

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: dts: armadillo800eva: Split LCD mux and gpio

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 ++
 1 file changed, 2 insertions(+)
