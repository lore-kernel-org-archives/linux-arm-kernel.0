From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:26 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v3.18
Message-ID: <cover.1409792871.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC DT updates for
v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-dt2-for-v3.18,
which I have already sent a pull-request for.


The following changes since commit f170b97c9ad0b8ba3e99f02cbadc7676383fee09:

  ARM: shmobile: sh73a0 dtsi: Move interrupt-parent to the top (2014-08-22 12:34:53 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.18

for you to fetch changes up to 40c488df84f9fbf4b84b4baed6e2cec4a2d946ed:

  ARM: shmobile: kzm9g-reference dts: Use tabs for indentation (2014-09-02 10:22:42 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v3.18

* Use tabs for indentation in kzm9g-reference and r8a7779 DTS(I) files
* Add platform device tree bindings documentation
* Add SoC-specific thermal compatible property to r8a73a4 and r8a7779

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: shmobile: r8a7779 dtsi: Add SoC-specific thermal compatible property
      ARM: shmobile: r8a73a4 dtsi: Add SoC-specific thermal compatible property
      ARM: shmobile: Add platform device tree bindings documentation
      ARM: shmobile: r8a7779 dtsi: Use tabs for indentation
      ARM: shmobile: kzm9g-reference dts: Use tabs for indentation

 Documentation/devicetree/bindings/arm/shmobile.txt | 71 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi                     |  2 +-
 arch/arm/boot/dts/r8a7779.dtsi                     | 10 +--
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  4 +-
 4 files changed, 79 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
