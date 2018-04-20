From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:06:04 +0200
Subject: [PATCH v1 0/4] Add DMAv2 and DMAMUX Support on STM32MP157C
Message-ID: <1524215164-14145-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMAv2 and DMAMUX support on STM32MP157C with configs and device tree.
---
  Version history:
     v1:
        * Initial
---

Pierre-Yves MORDRET (4):
  ARM: configs: stm32: Add DMAv2 support on STM32MP157C machine
  ARM: configs: stm32: Add DMAMUX support on STM32MP157C
  ARM: dts: stm32: Add DMAv2 support on STM32MP157C
  ARM: dts: stm32: Add DMAMUX support on STM32MP157C

 arch/arm/boot/dts/stm32mp157c.dtsi | 44 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32/Kconfig        |  2 ++
 2 files changed, 46 insertions(+)

-- 
2.7.4
