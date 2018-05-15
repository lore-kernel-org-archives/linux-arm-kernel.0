From: erwan.leray@st.com (Erwan Le Ray)
Date: Tue, 15 May 2018 14:23:57 +0200
Subject: [PATCH 0/2] m_can support to stm32mp157c
Message-ID: <1526387039-14813-1-git-send-email-erwan.leray@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Controller Area Network m_can to STM32MP157C SoC and
activation on stm32mp157c-ev1 board

Bich Hemon (2):
  ARM: dts: stm32: m_can support to stm32mp157c
  ARM: dts: stm32: m_can activation on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     |  6 ++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

-- 
1.9.1
