From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 3 Oct 2018 17:11:02 +0200
Subject: [PATCH 0/3] ARM: dts: stm32: add dmas to stm32mp157c timers
Message-ID: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds dmas description to stm32mp157c device tree file.
But dmas are kept disabled by default on all boards. They are only
necessary for PWM capture. So, spare them for other usage by default.

Fabrice Gasnier (3):
  ARM: dts: stm32: Add dmas to timer on stm32mp157c
  ARM: dts: stm32: don't use timers dmas on stm32mp157c-ed1
  ARM: dts: stm32: don't use timers dmas on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ed1.dts |  3 ++
 arch/arm/boot/dts/stm32mp157c-ev1.dts |  7 +++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 58 +++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
1.9.1
