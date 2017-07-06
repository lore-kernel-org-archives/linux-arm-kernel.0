From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 6 Jul 2017 10:47:43 +0200
Subject: [PATCHv2 0/2] rtc: add support for STM32H7 RTC
Message-ID: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for STM32H7 Real Time Clock variant.
Difference is regarding clocks: there is a 'pclk' clock on STM32H7
for register access.

Amelie Delaunay (2):
  dt-bindings: rtc: stm32: add support for STM32H7
  rtc: stm32: add STM32H7 RTC support

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 +++++++--
 drivers/rtc/rtc-stm32.c                            | 82 +++++++++++++++++-----
 2 files changed, 92 insertions(+), 22 deletions(-)

-- 
1.9.1
