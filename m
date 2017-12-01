From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 1 Dec 2017 17:36:49 +0100
Subject: [PATCH  0/2] serial: stm32: fix name conflict
Message-ID: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series:
-fix name conflict, when both driver 8250/stm32-usart
are activated. Replace stm32 tty name "ttyS" by "ttySTM".
-by default add stm32 console when SERIAL_STM32 is selected.

Ludovic Barre (2):
  serial: stm32: add default console
  serial: stm32: fix name conflict with 8250

 drivers/tty/serial/Kconfig       | 1 +
 drivers/tty/serial/stm32-usart.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
