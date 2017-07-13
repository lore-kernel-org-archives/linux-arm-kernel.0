From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 13 Jul 2017 15:08:27 +0000
Subject: [PATCH 3/9] serial: stm32: Increase maximum number of ports
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Message-ID: <1499958494-19354-4-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gerald Baeza <gerald.baeza@st.com>

Increase max number of ports for stm32h7
which supports up to 8 uart and usart instances.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 65b4ffa..6092789 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -206,7 +206,7 @@ struct stm32_usart_info stm32f7_info = {
 #define USART_ICR_CMCF		BIT(17)		/* F7 */
 
 #define STM32_SERIAL_NAME "ttyS"
-#define STM32_MAX_PORTS 6
+#define STM32_MAX_PORTS 8
 
 #define RX_BUF_L 200		 /* dma rx buffer length     */
 #define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
-- 
1.9.1
