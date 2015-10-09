From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Oct 2015 20:48:49 +0200
Subject: [GIT PULL 1/2] ARM64: berlin: DT changes for v4.4 (round 1)
Message-ID: <1444416530-3207-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is Marvell Berlin ARM64 DT changes round 1 for v4.4. Jisheng
from Marvell added GPIO nodes and a new board for the BG4-CT SoC.

Please pull.

Sebastian

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin64-dt-for-4.4-1

for you to fetch changes up to 59995f55973e23d957f1dad13446554f6aef73d0:

  arm64: dts: add dts file for Marvell Berlin4CT STB board (2015-09-20 21:04:02 +0200)

----------------------------------------------------------------
Marvell Berlin ARM64 DT for 4.4 take 1
- add BG4CT GPIO nodes
- add BG4CT STB reference board

----------------------------------------------------------------
Jisheng Zhang (2):
      arm64: dts: berlin4ct: add GPIO nodes
      arm64: dts: add dts file for Marvell Berlin4CT STB board

 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts |  66 ++++++++++++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 120 ++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
