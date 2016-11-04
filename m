From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 4 Nov 2016 09:52:55 +0100
Subject: [PATCH 0/2] STM32F4 Enable RTC & QSPI clocks
Message-ID: <1478249577-25999-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set enables RTC & QSPI clocks.

Gabriel Fernandez (2):
  ARM: dts: stm32f429: add LSI and LSE clocks
  ARM: dts: stm32f429: Add QSPI clock

 arch/arm/boot/dts/stm32f429.dtsi      | 18 ++++++++++++++++++
 arch/arm/boot/dts/stm32f469-disco.dts |  4 ++++
 2 files changed, 22 insertions(+)

-- 
1.9.1
