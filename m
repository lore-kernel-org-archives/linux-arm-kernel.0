From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 15 Sep 2014 17:59:28 +0200
Subject: [GIT PULL] arm: mediatek: Add more basic features
Message-ID: <CABuKBeJJ5ijy6CXPHbrzrkgJDVz99BmdACx+wRZ-KbVjKx2kLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please prepare for the next round of Mediatek patches for the mt6589.
This patch set adds some minor changes to the Mediatek mt6589 support.

Features are low-level debugging on the mt6589, the addition to the
"make dtbs" and multi_v7_defconfig,as well as some small changes in
the DTS files.

Cheers,
Matthias

---

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.18-next-mt6589

for you to fetch changes up to 467dc3a11b4c82dd94f4d0e8d6894cc60adef5ea:

  arm: dts: mt6589: Change compatible string for GIC (2014-09-09 18:37:50 +0200)

----------------------------------------------------------------
Minor changes to the mt6589 support

----------------------------------------------------------------
Matthias Brugger (7):
      arm: dts: Build dtb for Mediatek board
      arm: multi_v7_defconfig: Enable Mediatek platform
      arm: dts: mt6589: Fix typo in GIC unit address
      arm: mediatek: Add earlyprintk support for mt6589
      arm: dts: mt6589-aquaris5: Add boot argument earlyprintk
      arm: dts: mediatek: Add compatible property for aquaris5
      arm: dts: mt6589: Change compatible string for GIC

 Documentation/devicetree/bindings/arm/mediatek.txt |  6 ++++++
 arch/arm/Kconfig.debug                             | 10 ++++++++++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/mt6589-aquaris5.dts              |  5 +++++
 arch/arm/boot/dts/mt6589.dtsi                      |  4 ++--
 arch/arm/configs/multi_v7_defconfig                |  1 +
 6 files changed, 25 insertions(+), 2 deletions(-)
