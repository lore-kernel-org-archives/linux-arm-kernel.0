From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:05:20 +0200
Subject: [PATCH v1 0/2] Add I2C support for STM32H743
Message-ID: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C support on STM32H743 SoC.
Activate I2C1 on STM32H743I Evaluation Board.
---
  Version history:
     v1:
        * Initial
---

Pierre-Yves MORDRET (2):
  ARM: dts: stm32: Add I2C support for STM32H743 SoC
  ARM: dts: stm32: Add I2C1 support for STM32H743I-EVAL Board

 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 10 +++++++
 arch/arm/boot/dts/stm32h743.dtsi         | 48 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    |  8 ++++++
 3 files changed, 66 insertions(+)

-- 
2.7.4
