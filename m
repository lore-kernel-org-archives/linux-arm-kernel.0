From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Jan 2017 16:52:11 +0100
Subject: [PATCH 0/3] STM32F4 Clock binding fix & update
Message-ID: <1483717934-21415-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set includes:
 - a fix to STM32F4_XXXX_CLOCK() macro
 - an update of missing binding definition
 - a patch to use STM32F4_XXXX_CLOCK() macro

Gabriel Fernandez (3):
  dt-bindings: mfd: stm32f4: Fix STM32F4_XXXX_CLOCK() macro
  dt-bindings: mfd: stm32f4: Add missing binding definition
  ARM: dts: stm32: Use clock DT binding definition on stm32f429 family

 arch/arm/boot/dts/stm32429i-eval.dts  |  2 +-
 arch/arm/boot/dts/stm32f429.dtsi      | 66 +++++++++++++++++++----------------
 include/dt-bindings/mfd/stm32f4-rcc.h | 24 +++++++++----
 3 files changed, 53 insertions(+), 39 deletions(-)

-- 
1.9.1
