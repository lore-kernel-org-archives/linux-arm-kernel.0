From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 24 May 2018 16:04:20 +0800
Subject: [GIT PULL] berlin dt64 changes for v4.18
Message-ID: <20180524160420.35da91b5@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the pull request for berlin dt64 changes for v4.18.

Thanks,
Jisheng

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin64-dt-for-v4.18

for you to fetch changes up to 031106ce95a201f6dd4c5ebf35abb900cf34e2ba:

  arm64: dts: move berlin SoC files from marvell dir to synaptics dir (2018-05-24 13:25:45 +0800)

----------------------------------------------------------------
Berlin64 DT changes for v4.18

 - use SPDX-License-Identifier for dts(i) files
 - move berlin SoC dts(i) files from marvell dir to synaptics dir

----------------------------------------------------------------
Jisheng Zhang (3):
      arm64: dts: berlin4ct: use SPDX-License-Identifier
      arm64: dts: berlin4ct-*.dts: use SPDX-License-Identifier
      arm64: dts: move berlin SoC files from marvell dir to synaptics dir

 arch/arm64/boot/dts/Makefile                       |  1 +
 arch/arm64/boot/dts/marvell/Makefile               |  4 --
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts      | 66 ----------------------
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts      | 66 ----------------------
 arch/arm64/boot/dts/synaptics/Makefile             |  4 ++
 arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts    | 29 ++++++++++
 arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts    | 29 ++++++++++
 .../boot/dts/{marvell => synaptics}/berlin4ct.dtsi | 39 +------------
 8 files changed, 64 insertions(+), 174 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
 delete mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
 create mode 100644 arch/arm64/boot/dts/synaptics/Makefile
 create mode 100644 arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
 create mode 100644 arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi (78%)
