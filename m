From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Mar 2017 10:40:21 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.12
Message-ID: <cover.1489138765.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.12.


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.12

for you to fetch changes up to 58e7696e0e3c085804fb6754a7dadf7267d0fa77:

  arm64: defconfig: Enable SH Mobile I2C controller (2017-03-06 10:03:53 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.12

* Enable SH Mobile I2C controller

----------------------------------------------------------------
Simon Horman (1):
      arm64: defconfig: Enable SH Mobile I2C controller

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
