From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 30 Mar 2015 16:56:17 +0200
Subject: [GIT PULL] ARM: mediatek: dts updates for v4.1
Message-ID: <CABuKBeKw7qhHzB2gZ31RCqCTB0gJHFcdR0d3r_aqPT-HNCbX0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull the following changes.

Thanks,
Matthias

---

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.0-next-dts

for you to fetch changes up to 85fc20b2ad9937fccbff3b47841f33d47e5e62c8:

  ARM: DTS: Add watchdog to mt6589 (2015-03-30 13:18:23 +0200)

----------------------------------------------------------------
- Add pinctrl/GPIO/EINT node for mt8135.
- document binding for the PMIC wrapper
- Add watchdog to mt6589

----------------------------------------------------------------
Hongzhou Yang (1):
      ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for mt8135.

Matthias Brugger (1):
      ARM: DTS: Add watchdog to mt6589

Sascha Hauer (1):
      dt-bindings: ARM: Mediatek: document binding for the PMIC wrapper

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   58 +
 arch/arm/boot/dts/mt6589.dtsi                      |    5 +
 arch/arm/boot/dts/mt8135-pinfunc.h                 | 1302 ++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi                      |   25 +
 4 files changed, 1390 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
 create mode 100644 arch/arm/boot/dts/mt8135-pinfunc.h
