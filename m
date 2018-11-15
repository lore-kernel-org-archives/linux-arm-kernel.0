From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 15 Nov 2018 08:52:28 +0000
Subject: [PATCH 0/3] CAN fix for stm32mp157c
Message-ID: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset changes the CAN RAM mapping and adds CAN sleep pins.

Bich Hemon (3):
  ARM: dts: stm32: change CAN RAM mapping on stm32mp157c
  ARM: dts: stm32: add can1 sleep pins muxing
  ARM: dts: stm32: add can1 sleep pins muxing on stm32mp157c-ev1 board

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 7 +++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 3 ++-
 arch/arm/boot/dts/stm32mp157c.dtsi        | 4 ++--
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
1.9.1
