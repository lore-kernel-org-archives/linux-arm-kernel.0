From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Feb 2016 15:25:23 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.6 (#1)
Message-ID: <871t8n2sa4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig for mvebu for v4.6.

Gregory

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.6-1

for you to fetch changes up to e1995f5586c9a60eefb188bc4ce3d4f37a6b835b:

  ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD (2016-01-26 09:40:58 +0100)

----------------------------------------------------------------
mvebu defconfig for 4.6 (part 1)

- Enable sound module needed for OpenRD in mvebu_v5_defconfig
- Add USB nop xceiv support in mvebu_v7_defconfig

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Add USB nop xceiv support in mvebu_v7_defconfig

Martin Michlmayr (1):
      ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD

 arch/arm/configs/mvebu_v5_defconfig | 1 +
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

--
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
