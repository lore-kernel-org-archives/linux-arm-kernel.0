From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 30 Mar 2015 16:54:54 +0200
Subject: [GIT PULL] ARM: mediatek: arm64 changes for 4.1
Message-ID: <CABuKBeKb99suZ=QycVvyy18N+Ooz=+rBM8mStxqyoaT=gtN0zQ@mail.gmail.com>
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

  https://github.com/mbgg/linux-mediatek.git tags/v4.0-next-arm64

for you to fetch changes up to 359f9365d3f8d0d62683344807c986ec7d711b59:

  arm64: dts: mt8173: Add pinctrl/GPIO/EINT node for mt8173.
(2015-03-10 11:20:30 +0100)

----------------------------------------------------------------
- Select PINCTRL for Mediatek platform
- Add pinctrl/GPIO/EINT node for mt8173.

----------------------------------------------------------------
Hongzhou Yang (1):
      arm64: dts: mt8173: Add pinctrl/GPIO/EINT node for mt8173.

Yingjoe Chen (1):
      arm64: mediatek: Select PINCTRL for Mediatek platform

 arch/arm64/Kconfig                            |   1 +
 arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h | 682 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  20 +
 3 files changed, 703 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h
