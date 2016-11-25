From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 25 Nov 2016 17:53:39 +0800
Subject: [GIT PULL] ARM64: berlin: DT changes for v4.10
Message-ID: <20161125175339.40748efa@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the first time I send pull request for berlin SoC. This is a PR for
the Berlin64 DT changes for v4.10. Please pull.

Thanks,
Jisheng

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin64-dt-for-v4.10-1

for you to fetch changes up to 40fdc6b0d2b96cac46be51eb41042a715047b791:

  arm64: dts: berlin4ct-dmp: add missing unit name to /memory node (2016-11-25 17:14:00 +0800)

----------------------------------------------------------------
Berlin64 DT changes for v4.10

- fix some dtc compiler warnings

----------------------------------------------------------------
Jisheng Zhang (3):
      arm64: dts: berlin4ct: add missing unit name to /soc node
      arm64: dts: berlin4ct-stb: add missing unit name to /memory node
      arm64: dts: berlin4ct-dmp: add missing unit name to /memory node

 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts | 2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 2 +-
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
