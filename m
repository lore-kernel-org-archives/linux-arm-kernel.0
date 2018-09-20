From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 20 Sep 2018 18:34:15 +0200
Subject: [PATCH 0/2] STM32: Fixes for 4.19 cycle
Message-ID: <1537461257-2940-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, olof and Kevin

Those 2 patches fixe the same issue on 4.19-rc: a bad usage of the mdma
binding inside stm32mp157c.dts file. Can you please add them as fixe for 4.19 ?

Thanks in advance
Alex

Alexandre Torgue (1):
  ARM: dts: stm32: update HASH1 dmas property on stm32mp157c

Amelie Delaunay (1):
  ARM: dts: stm32: update SPI6 dmas property on stm32mp157c

 arch/arm/boot/dts/stm32mp157c.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
