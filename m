From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 27 Apr 2016 16:16:10 +0100
Subject: [GIT PULL] arm64: dts: hisilicon: hip05 and hip06 SoC updates for 4.7
Message-ID: <5720D7BA.2050107@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip0x-dt-for-4.7

for you to fetch changes up to 4cfcb35189f62ae351194827fca1787053a66235:

  Documentation: arm64: Add Hisilicon Hip06 D03 dts binding (2016-04-27 15:40:13 +0100)

----------------------------------------------------------------
ARM64: DT: Hisilicon hip05 and hip06 updates for 4.7

- Fix its node without msi-cells for hip05
- Add nor flash node for hip05 D02 board
- Add initial dts for hip06 D03 board
- Reorder and add the hip06 D03 binding in the binding document

----------------------------------------------------------------
Kefeng Wang (4):
      arm64: dts: hip05: fix its node without msi-cells
      arm64: dts: hip05: Add nor flash support
      arm64: dts: Add initial dts for Hisilicon Hip06 D03 board
      Documentation: arm64: Add Hisilicon Hip06 D03 dts binding

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |  20 +++++----
 arch/arm64/boot/dts/hisilicon/Makefile                        |   4 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts                   |  34 +++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi                      |  10 +++++
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts                   |  34 +++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi                      | 307 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 400 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06-d03.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06.dtsi
