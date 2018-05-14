From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 14 May 2018 15:56:08 +0000
Subject: [GIT PULL] STi DT update for v4.18 round 1
Message-ID: <11f8376c-860d-26cf-92f6-38737e513656@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.18

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
tags/sti-dt-for-v4.18-round1

for you to fetch changes up to c5bf208a0dc4aee18e03c6ed97eada70ffa9a4d8:

   ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage 
(2018-05-14 17:40:26 +0200)

----------------------------------------------------------------
STi DT update for 4.18:
  - Fix complain about IRQ_TYPE_NONE_usage

----------------------------------------------------------------
Patrice Chotard (5):
       ARM: dts: stih407-family: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stih407: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage

  arch/arm/boot/dts/stih407-family.dtsi  | 52 
+++++++++++++++++-----------------
  arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++----
  arch/arm/boot/dts/stih407.dtsi         |  2 +-
  arch/arm/boot/dts/stih410.dtsi         | 18 ++++++------
  arch/arm/boot/dts/stihxxx-b2120.dtsi   |  4 +--
  5 files changed, 43 insertions(+), 43 deletions(-)
