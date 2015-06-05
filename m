From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 5 Jun 2015 16:24:27 +0100
Subject: [GIT PULL]Hisilicon 64-bit soc hi6220 DT changes for 4.2
Message-ID: <5571BF2B.5080500@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hi6620-dt-for-4.2

for you to fetch changes up to 86e8f528ef325843d9b01ee6d00823e667cab5e2:

  arm64: dts: Add dts files for Hisilicon Hi6220 SoC (2015-06-05 15:30:06 +0100)

----------------------------------------------------------------
ARM64: DT: Hisilicon hi6220 soc and hikey board updates for 4.2

- Added the devicetree bindings document for hi6220 SoC
- Added the devicetree bindings document for hi6220 clock
- Added dts files for hi6220 SoC and hikey board

----------------------------------------------------------------
Bintian Wang (3):
      arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
      clk: hi6220: Document devicetree bindings for hi6220 clock
      arm64: dts: Add dts files for Hisilicon Hi6220 SoC

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |  87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/hi6220-clock.txt      |  34 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/Makefile                                  |   1 +
 arch/arm64/boot/dts/hisilicon/Makefile                        |   5 ++++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts                |  31 +++++++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi                     | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
 create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
