From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 16:59:53 +0200
Subject: [PATCH 0/3] Add STM32 USBPHYC to stm32mp157c
Message-ID: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STM32 USBPHYC (USB PHY Controller) to
stm32mp157c SoC and enables it on stm32mp157c-ev1 board.

Amelie Delaunay (3):
  ARM: dts: stm32: add USBPHYC support to stm32mp157c
  ARM: dts: stm32: add supplies to usbphyc ports on stm32mp157c-ed1
  ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 12 ++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts |  5 +++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

-- 
2.7.4
