From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 May 2015 12:27:13 +0200
Subject: [GIT PULL] Ux500 device tree changes for v4.2
Message-ID: <CACRpkdbaiYWRh8tGJbhvsnXXdsKYVVWo3V_C2_OPsZG3Xjuu5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a set of device tree changes for Ux500 targeted for the v4.2
merge window. Split off from the earlier big pull request.

Please pull it in!


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-v4.2-dt

for you to fetch changes up to df44ad87abcbe3bbba18b7e34555f343256e7b21:

  ARM: ux500: add the sensors to the STUIB board (2015-05-13 12:22:19 +0200)

----------------------------------------------------------------
Ux500 Device Tree changes for the v4.2 series:
Define CPU topology, connect that with CoreSight blocks,
add sensor information to DT boards.

----------------------------------------------------------------
Linus Walleij (5):
      ARM: ux500: define CPU topology
      ARM: ux500: add CoreSight blocks to DTS file
      ARM: ux500: fix lsm303dlh magnetometer compat string
      ARM: ux500: assign the sensor trigger IRQs
      ARM: ux500: add the sensors to the STUIB board

 arch/arm/boot/dts/ste-dbx5x0.dtsi          | 154 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href-stuib.dtsi      |  50 ++++++++++
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi |   7 +-
 arch/arm/boot/dts/ste-snowball.dts         |  23 ++++-
 4 files changed, 230 insertions(+), 4 deletions(-)
