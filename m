From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 26 Jun 2017 11:51:27 +0200
Subject: [PATCH 0/2] rtc: add support for STM32H7 RTC
Message-ID: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for STM32H7 Real Time Clock variant.
Difference is regarding clocks: there is a 'pclk' clock on STM32H7
for register access.

Amelie Delaunay (2):
  dt-bindings: rtc: stm32: add support for STM32H7
  rtc: stm32: add STM32H7 RTC support

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 ++++++--
 drivers/rtc/rtc-stm32.c                            | 85 +++++++++++++++++-----
 2 files changed, 95 insertions(+), 22 deletions(-)

-- 
1.9.1
