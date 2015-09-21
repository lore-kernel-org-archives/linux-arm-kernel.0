From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 21 Sep 2015 17:36:35 +0100
Subject: [GIT PULL]Hisilicon arm64 dt changes for 4.3
Message-ID: <56003213.2050306@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip05-dt-for-4.3

for you to fetch changes up to fcab303c015397c307ae4873e02598f89a4a3ef6:

  arm64: dts: add dts files for Hisilicon Hip05-D02 Development Board (2015-09-21 15:50:50 +0100)

----------------------------------------------------------------
ARM64: DT: Hisilicon hip05 soc and D02 board updates for 4.3

- Updated the hisilicon devicetree bindings document to support hip05-D02 board
- Added dts files for hip05 SoC and D02 board

----------------------------------------------------------------
Ding Tianhong (2):
      arm64: hip05-d02: Document devicetree bindings for Hisilicon Hip05-D02 Board
      arm64: dts: add dts files for Hisilicon Hip05-D02 Development Board

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |   4 ++
 arch/arm64/boot/dts/hisilicon/Makefile                        |   2 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts                   |  36 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi                      | 271 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05-d02.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05.dtsi
