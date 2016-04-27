From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:06:43 +1000
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for v4.7
Message-ID: <cover.1461723181.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates for v4.7.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.7,
which I have already sent a pull-request for.


The following changes since commit 81ae0ac31bb90baef10850fdfdc2a9f72f36aa6f:

  arm64: dts: r8a7795: Use USB3.0 fallback compatibility string (2016-03-28 08:52:47 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.7

for you to fetch changes up to 9f33a8a9e1b7dbb0b91a58af958d1c301a6fab1a:

  arm64: dts: r8a7795: Don't disable referenced optional clocks (2016-04-27 11:48:34 +1000)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.7

* Don't disable referenced optional clocks in DT of r8a7795 SoC
* Populate EXTALR in DT of salvator-x board
* Enable PCIe in DT of salvator-x board

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: dts: r8a7795: Don't disable referenced optional clocks

Phil Edworthy (2):
      arm64: dts: r8a7795: Add PCIe nodes
      arm64: dts: r8a7795: enable PCIe on Salvator-X

Wolfram Sang (1):
      arm64: dts: salvator-x: populate EXTALR

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 17 +++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 58 +++++++++++++++++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)
