From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 13 Oct 2015 14:28:01 +0300
Subject: [PATCH 0/3] ARM: digicolor: add pinctrl support
Message-ID: <cover.1444735169.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

This series enables the Conexant Digicolor CX92755 pinctrl driver. The driver 
itself was merged during the v4.3 cycle in commit 38b0e5071eca (pinctrl: driver 
for Conexant Digicolor CX92755 pin mapping)

Please consider for v4.4.

Thanks,
baruch

Baruch Siach (3):
  ARM: digicolor: select pinctrl/gpio driver
  ARM: digicolor: add pinctrl module device node
  ARM: digicolor: dts: add uart pin configuration

 arch/arm/boot/dts/cx92755.dtsi        | 7 +++++++
 arch/arm/boot/dts/cx92755_equinox.dts | 9 +++++++++
 arch/arm/mach-digicolor/Kconfig       | 3 +++
 3 files changed, 19 insertions(+)

-- 
2.6.1
