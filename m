From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:54:57 +0900
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC Defconfig Updates
 for v4.5
Message-ID: <cover.1448588763.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC defconfig
updates for v4.5.

This pull request Enable Renesas sound, DMAC, I2C, EthernetAVB and GPIO for
R-Car Gen3 r8a7795/salvator-x.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-defconfig-for-v4.5,
which I have already sent a pull-request for.


The following changes since commit 727e8d0126e3ecafce3ebc43eaa5a7d61af3bef0:

  arm64: defconfig: renesas: Enable Renesas r8a7795 SoC (2015-11-17 02:50:29 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig2-for-v4.5

for you to fetch changes up to 05a64b3b8b41bf3c3ca9b7f9f8a0e81ffadb20e3:

  arm64: defconfig: add Renesas sound and AK4613 support (2015-11-26 11:35:21 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC Defconfig Updates for v4.5

* Enable Renesas Sound, DMAC, I2C, EthernetAVB and GPIO for
  R-Car Gen3 r8a7795/salvator-x

----------------------------------------------------------------
Kuninori Morimoto (3):
      arm64: defconfig: Enable Renesas R-Car I2C Controller
      arm64: defconfig: add Renesas R-Car DMAC driver support
      arm64: defconfig: add Renesas sound and AK4613 support

Simon Horman (1):
      arm64: defconfig: enable EthernetAVB

Takeshi Kihara (1):
      arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC

 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
