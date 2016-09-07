From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:41:26 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.9
Message-ID: <cover.1473233745.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.9.


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.9

for you to fetch changes up to 6c04d2f7f1038bf6e5561827f862c6aa2beb4b37:

  arm64: defconfig: Enable SDHI and GPIO_REGULATOR (2016-09-01 16:32:46 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.9

* Enable HSUSB and SDHI

----------------------------------------------------------------
Simon Horman (1):
      arm64: defconfig: Enable SDHI and GPIO_REGULATOR

Yoshihiro Shimoda (1):
      arm64: defconfig: Add Renesas R-Car HSUSB driver support as module

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
