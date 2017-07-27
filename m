From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 27 Jul 2017 16:53:01 +0530
Subject: [GIT PULL] DaVinci fixes for v4.13
Message-ID: <6dc06dd1-0d7b-1988-d5c9-9cfafcf847f3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:

  Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.13

for you to fetch changes up to 6ea57ad6b9526f8106d0bf410b41a7223462ff89:

  ARM: dts: da850-lcdk: drop unused VPIF endpoints (2017-07-27 16:29:44 +0530)

----------------------------------------------------------------
Drop unused VPIF endpoints from device-tree.
They should be used only when an actual
remote-endpoint is connected.

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: dts: da850-evm: drop unused VPIF endpoints
      ARM: dts: da850-lcdk: drop unused VPIF endpoints

 arch/arm/boot/dts/da850-evm.dts  | 21 ---------------------
 arch/arm/boot/dts/da850-lcdk.dts |  7 -------
 2 files changed, 28 deletions(-)
