From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2017 10:29:30 +0100
Subject: [GIT PULL] Ux500 devicetree changes for v4.11
Message-ID: <CACRpkdbOrFAgOn_vr8vLc9pGHqzkm+Os9MrhxJjs0xxzMHO+Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

sorry for the late pull request, but these really should be going to
4.11. As late or whatever is fine.

I found a number of bugs in the platform that had been accumulating
and it would be nice to iron out most of them in v4.11.

Please pull this to the ARM SoC tree in some apropriate branch.

Yours,
Linus Walleij

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dt-1

for you to fetch changes up to 3015d3b05239e33b42b1ae9ac408cc60fa4772ce:

  ARM: dts: add the AB8500 sysclk to the device trees (2017-01-31
22:15:06 +0100)

----------------------------------------------------------------
Ux500 Device Tree updates for v4.11:

This cleans the device tree a bit and rectifies some
clocking bugs. They are in a sense regressions, but there
is no hurry for this platform.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: push MMC/SD to board and add comments
      ARM: dts: Ux500: move USB PHY pins to PHY device
      ARM: dts: add the AB8500 sysclk to the device trees

 arch/arm/boot/dts/ste-dbx5x0.dtsi      |  2 ++
 arch/arm/boot/dts/ste-href.dtsi        | 16 +++++++++-------
 arch/arm/boot/dts/ste-hrefprev60.dtsi  |  1 +
 arch/arm/boot/dts/ste-hrefv60plus.dtsi |  1 +
 arch/arm/boot/dts/ste-snowball.dts     | 20 +++++++++++++-------
 5 files changed, 26 insertions(+), 14 deletions(-)
