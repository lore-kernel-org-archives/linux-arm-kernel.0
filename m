From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 18:18:59 +0200
Subject: [PATCH 0/2] Fixup STM32MP157 device tree
Message-ID: <1530029941-26089-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series:
 -remove gpio aliases as there are not used.
 -reorder nodes in stm32mp157c-ed1 file.

Regards
Alex

Alexandre Torgue (2):
  ARM: dts: stm32: remove gpio aliases for stm32mp157c
  ARM: dts: stm32: Reorder nodes in stm32mp157c-ed1

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 22 +++++++++++-----------
 arch/arm/boot/dts/stm32mp157c.dtsi    | 14 --------------
 2 files changed, 11 insertions(+), 25 deletions(-)

-- 
2.7.4
