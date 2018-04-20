From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:15:05 +0200
Subject: [PATCH v1 0/2] Add MDMA Support on STM32MP157C
Message-ID: <1524215707-14642-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MDMA support on STM32MP157C with configs and device tree.
---
  Version history:
     v1:
        * Initial
---

Pierre-Yves MORDRET (2):
  ARM: configs: stm32: Add MDMA support on STM32MP157C
  ARM: dts: stm32: Add MDMA support on STM32MP157C

 arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
 arch/arm/mach-stm32/Kconfig        |  1 +
 2 files changed, 11 insertions(+)

-- 
2.7.4
