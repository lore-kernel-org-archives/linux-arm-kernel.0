From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 9 Mar 2018 07:57:29 +0100
Subject: [PATCH RESEND 0/2] Add dsi clock for stm32f469 board
Message-ID: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set adds the dsi clock for stm32f469 board.

Gabriel Fernandez (2):
  clk: stm32: END_PRIMARY_CLK should be declare after CLK_SYSCLK
  clk: stm32: Add DSI clock for STM32F469 Board

 drivers/clk/clk-stm32f4.c                 | 11 ++++++++++-
 include/dt-bindings/clock/stm32fx-clock.h |  7 ++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
1.9.1
