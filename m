From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:04 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.15
Message-ID: <cover.1506678593.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.15.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.15

for you to fetch changes up to bb58b29899ff9c6d1e97727ec05b500e832ebd7d:

  arm64: defconfig: enable R8A77970 SoC (2017-09-25 09:19:10 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.15

* Enable the following to allow further test coverage
  - r8a77970 (V3M) and r8a77995 (D3) R-Car Gen3 SoCs
  - R-Car Gen3 thermal driver.
    This is used on a range of R-Car Gen3 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: defconfig: Enable Renesas R8A77995 SoC

Sergei Shtylyov (1):
      arm64: defconfig: enable R8A77970 SoC

Wolfram Sang (1):
      arm64: defconfig: enable thermal driver for Renesas R-Car Gen3

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)
