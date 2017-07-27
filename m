From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 27 Jul 2017 16:50:19 +0000
Subject: [PATCH] Add support for low-level debug on STM32
Message-ID: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds low-level debug support on USART1 for STM32F4 and STM32F7.

Gerald Baeza (1):
  ARM: stm32: debug: add low-level debug support

 arch/arm/Kconfig.debug         | 27 +++++++++++++++++++++++++++
 arch/arm/include/debug/stm32.S | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 arch/arm/include/debug/stm32.S

-- 
1.9.1
