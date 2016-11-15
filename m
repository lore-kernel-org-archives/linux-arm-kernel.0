From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:13:33 +0100
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.9
Message-ID: <20161115211333.oqvxfjxxudfkdq7j@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are our changes for arm64 DT for the next merge window.

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt64-for-4.10

for you to fetch changes up to 4e3886081848b7ea16452a92c4324acaab644d49:

  arm64: dts: add Pine64 support (2016-11-03 09:08:24 +0100)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.10

Support for the Allwinner A64, their first armv8 SoC.

----------------------------------------------------------------
Andre Przywara (3):
      arm64: dts: add Allwinner A64 SoC .dtsi
      Documentation: devicetree: add vendor prefix for Pine64
      arm64: dts: add Pine64 support

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  50 ++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  74 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 263 +++++++++++++++++++++
 8 files changed, 396 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/0327c43c/attachment.sig>
