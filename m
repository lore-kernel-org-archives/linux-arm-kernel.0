From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 15 Oct 2015 18:04:47 +0200
Subject: [GIT PULL] STi DT changes for v4.4, round 2
Message-ID: <561FCE9F.2010002@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STi DT updates for v4.4:

The following changes since commit cae010a1b663a779fdbfbf625839bc07dad16428:

   ARM: STi: STiH407: Enable the 2 HW Random Number Generators for 
STiH4{07, 10} (2015-10-01 11:02:09 +0200)

are available in the git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-dt-for-v4.4-2

for you to fetch changes up to 848dd6a87a10bd24b5a4c8b84eaba3cdd0ec7a19:

   ARM: STi: DT: Add support for stih418 A9 pll (2015-10-15 13:48:16 +0200)

----------------------------------------------------------------
Highlights:
-----------
  - Use STiH418's A9 PLL
  - Add Ethernet support to STiH407 family

----------------------------------------------------------------
Gabriel Fernandez (1):
       ARM: STi: DT: Add support for stih418 A9 pll

Maxime Coquelin (4):
       ARM: dts: Fix RGMII pinctrl timings
       ARM: dts: Add Ethernet node to STiH407 family
       ARM: dts: Enable Ethernet on STi's B2120 boards
       ARM: dts: Enable Ethernet on STi's B2199 board

  arch/arm/boot/dts/stih407-b2120.dts    |  1 +
  arch/arm/boot/dts/stih407-family.dtsi  | 27 +++++++++++++++++++++++++++
  arch/arm/boot/dts/stih407-pinctrl.dtsi |  4 ++--
  arch/arm/boot/dts/stih410-b2120.dts    |  1 +
  arch/arm/boot/dts/stih418-b2199.dts    |  8 ++++++++
  arch/arm/boot/dts/stih418-clock.dtsi   |  2 +-
  arch/arm/boot/dts/stihxxx-b2120.dtsi   |  6 ++++++
  7 files changed, 46 insertions(+), 3 deletions(-
