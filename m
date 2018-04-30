From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 30 Apr 2018 09:11:19 +0200
Subject: [PATCH 0/2] ARM: dts: stm32: add qspi support for stm32mp157c
Message-ID: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds qspi support for stm32mp157c SoC
and its eval board.

Ludovic Barre (2):
  ARM: dts: stm32: add qspi support for stm32mp157c
  ARM: dts: stm32: add flash nor support on stm32mp157c eval board

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 45 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 25 +++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 11 ++++++++
 3 files changed, 81 insertions(+)

-- 
2.7.4
