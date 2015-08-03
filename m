From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  3 Aug 2015 21:24:44 +0200
Subject: [GIT PULL] ARM: berlin: Initial Marvell Berlin ARM64 support
Message-ID: <1438629886-6390-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

this is initial Marvell Berlin4CT ARM64 support for v4.3. It contains minimum SoC
dtsi and basic dts for the development board. The patches have been posted by
Marvell's Jisheng Zhang a while ago on the lists.

Please pull.

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin64-for-v4.3-1

for you to fetch changes up to d93ac74ad150c89f2d0a3b90754cbccdc6ab102c:

  arm64: dts: Add dts files for Marvell Berlin4CT SoC (2015-08-03 20:45:54 +0200)

----------------------------------------------------------------
Initial support for Marvell Berlin4CT ARM64 SoC

----------------------------------------------------------------
Jisheng Zhang (1):
      arm64: dts: Add dts files for Marvell Berlin4CT SoC

 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/marvell/Makefile          |   5 +
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts |  66 +++++++++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 164 ++++++++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/Makefile
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct.dtsi
