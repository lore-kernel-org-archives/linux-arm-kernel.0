From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:14 +0900
Subject: [GIT PULL] Third Round of Renesas ARM64 Based SoC DT Updates for v4.5
Message-ID: <cover.1450401186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM64 based SoC DT updates
for v4.5.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt2-for-v4.5,
which you have already pulled.


The following changes since commit 672b79312c04016481a11d4b996b4512207ffbd3:

  arm64: renesas: salvator-x: Sound DVC support (2015-11-26 11:31:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt3-for-v4.5

for you to fetch changes up to 2eb2b5066197eab00c55dcd1132f17836e4975b2:

  arm64: renesas: r8a7795: fix SATA clock assignment (2015-12-18 10:07:29 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM64 Based SoC DT Updates for v4.5

* Enable SATA
* Add salvator-x part number to DT bindings documentation
* Enable all four A57 cores instead of just one
* Enhanced audio support:
  - Use CS2000 as AUDIO_CLK_B
  - Set ak4613 In/Out pin as single-end

----------------------------------------------------------------
Gaku Inami (2):
      arm64: dts: r8a7795: Add PSCI node
      arm64: dts: r8a7795: Add Cortex-A57 CPU cores

Geert Uytterhoeven (1):
      arm64: renesas: salvator-x: Add board part number to DT bindings

Kouei Abe (2):
      arm64: dts: r8a7795: Add SATA controller node
      arm64: dts: salvator-x: Enable SATA controller

Kuninori Morimoto (2):
      arm64: renesas: salvator-x: set ak4613 In/Out pin as single-end
      arm64: renesas: salvator-x: use CS2000 as AUDIO_CLK_B

Ulrich Hecht (1):
      arm64: renesas: r8a7795: fix SATA clock assignment

Wolfram Sang (1):
      arm64: renesas: r8a7795: add internal delay for i2c IPs

Yoshifumi Hosoya (1):
      arm64: dts: r8a7795: Add pmu device nodes

 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 51 +++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 64 ++++++++++++++++++++--
 3 files changed, 110 insertions(+), 7 deletions(-)
