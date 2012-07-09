From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 9 Jul 2012 20:57:33 +0200
Subject: [GIT PULL] at91: a little dt pull request for 3.6
Message-ID: <4FFB299D.7030902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, hi Olof,

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-for-next-dt

for you to fetch changes up to 3c68bb48214f87562b6956195178d991403d66d4:

  ARM: at91: Add support for board aks-cdu (2012-07-09 20:45:31 +0200)

----------------------------------------------------------------
Two new boards described with device tree

----------------------------------------------------------------
Fabio Porcedda (1):
      ARM: at91: add support for Telit EVK-PRO3 with Telit GE863-PRO3

Jiri Prchal (1):
      ARM: at91: Add support for board aks-cdu

 arch/arm/boot/dts/aks-cdu.dts     |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/evk-pro3.dts    |   41 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ge863-pro3.dtsi |   52 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile.boot  |    2 ++
 4 files changed, 208 insertions(+)
 create mode 100644 arch/arm/boot/dts/aks-cdu.dts
 create mode 100644 arch/arm/boot/dts/evk-pro3.dts
 create mode 100644 arch/arm/boot/dts/ge863-pro3.dtsi

Thanks, best regards,
-- 
Nicolas Ferre
