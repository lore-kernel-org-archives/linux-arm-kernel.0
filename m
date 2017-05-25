From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 25 May 2017 14:04:04 +0200
Subject: [GIT PULL] ARM: realtek: dt64 for v4.12
In-Reply-To: <20170525120404.32034-1-afaerber@suse.de>
References: <20170525120404.32034-1-afaerber@suse.de>
Message-ID: <20170525120404.32034-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is the initial dt64 pull for Realtek.
The Kconfig symbol is introduced in the arm64 pull.

Regards,
Andreas

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://github.com/afaerber/linux.git tags/realtek-arm64-dt-for-4.12

for you to fetch changes up to 72a7786c0a0d6554b1d2bd3c6a0c3589d4904fb3:

  ARM64: dts: Add Realtek RTD1295 and Zidoo X9S (2017-05-25 12:13:58 +0200)

----------------------------------------------------------------
Realtek ARM64 based SoC DT for v4.12

This adds an initial DT for the RTD1295 SoC and a TV box based on it.

----------------------------------------------------------------
Andreas F?rber (3):
      dt-bindings: Add vendor prefix for Zidoo
      dt-bindings: arm: Add Realtek RTD1295 bindings
      ARM64: dts: Add Realtek RTD1295 and Zidoo X9S

 Documentation/devicetree/bindings/arm/realtek.txt  |  20 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/realtek/Makefile               |   5 +
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |  42 +++++++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           | 131 +++++++++++++++++++++
 6 files changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 arch/arm64/boot/dts/realtek/Makefile
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi
