From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 23 Apr 2018 17:19:43 +0200
Subject: [PATCH 0/4] ARM: dts: Add cryptographic support for stm32mp157c
Message-ID: <20180423151947.2526-1-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches serie add support or RNG, CRYP and CRC IPs for stm32mp157c SoC
and add RNG default support for ev1 board.

Lionel Debieve (4):
  ARM: dts: stm32: Add RNG support on stm32mp157c
  ARM: dts: stm32: Enable RNG for stm32mp157c-ed1
  ARM: dts: stm32: Add CRYP support on stm32mp157c
  ARM: dts: stm32: Add CRC support on stm32mp157c

 arch/arm/boot/dts/stm32mp157c-ed1.dts |  4 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.15.1
