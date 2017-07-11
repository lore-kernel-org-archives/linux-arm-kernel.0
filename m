From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 11 Jul 2017 18:13:08 +0200
Subject: [PATCH 0/2] Enable ADC support on STM32H7
Message-ID: <1499789590-13021-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds ADC device-tree nodes to STM32H7 SoC and
enables ADC1 by default on stm32h743i-eval board.

Fabrice Gasnier (2):
  ARM: dts: stm32: add ADC support on stm32h7
  ARM: dts: stm32: enable ADC on stm32h743i-eval board

 arch/arm/boot/dts/stm32h743.dtsi      | 53 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts | 18 ++++++++++++
 2 files changed, 71 insertions(+)

-- 
1.9.1
