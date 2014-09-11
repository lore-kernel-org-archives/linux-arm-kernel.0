From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:15 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for v3.18
Message-ID: <cover.1410396013.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC DT updates for
v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-dt3-for-v3.18,
which you have already pulled.


The following changes since commit 40c488df84f9fbf4b84b4baed6e2cec4a2d946ed:

  ARM: shmobile: kzm9g-reference dts: Use tabs for indentation (2014-09-02 10:22:42 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt4-for-v3.18

for you to fetch changes up to a742795be9ceae2853ca71f216193f29da151da8:

  ARM: shmobile: Initial Alt board device tree (2014-09-09 11:29:27 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC DT Updates for v3.18

* Add r8a7794 SoC and Alt board device tree
* Correct lager memory map

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: lager: correct memory map

Ulrich Hecht (2):
      ARM: shmobile: Initial r8a7794 SoC device tree
      ARM: shmobile: Initial Alt board device tree

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/r8a7790-lager.dts       |   2 +-
 arch/arm/boot/dts/r8a7794-alt.dts         |  47 +++
 arch/arm/boot/dts/r8a7794.dtsi            | 531 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7794-clock.h |  80 +++++
 5 files changed, 661 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7794-alt.dts
 create mode 100644 arch/arm/boot/dts/r8a7794.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7794-clock.h
