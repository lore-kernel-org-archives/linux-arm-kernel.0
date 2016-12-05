From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 5 Dec 2016 16:33:15 +0530
Subject: [GIT PULL 1/2] DaVinci DT updates for v4.10 (part 4)
Message-ID: <20161205110316.18514-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 878e908ad95637dc6567a9b5f6876a580ae90dfa:

  ARM: dts: da850: enable memctrl and mstpri nodes per board (2016-11-28 15:51:29 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/dt-4

for you to fetch changes up to e4ce904d6289f2a72affd2a0f0a44da6e5d0cce4:

  ARM: dts: da850: enable high speed for mmc (2016-12-05 14:20:44 +0530)

----------------------------------------------------------------
- Add device tree nodes for pin pull-up/pull-down
bias control on DA850.

- Enable high speed support on DA850 MMC/SD

----------------------------------------------------------------
Axel Haslam (1):
      ARM: dts: da850: enable high speed for mmc

David Lechner (1):
      ARM: dts: da850: Add node for pullup/pulldown pinconf

 arch/arm/boot/dts/da850.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)
