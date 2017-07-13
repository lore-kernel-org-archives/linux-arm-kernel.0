From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 13 Jul 2017 15:08:26 +0000
Subject: [PATCH 1/9] serial: stm32: fix copyright
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Message-ID: <1499958494-19354-2-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix missing copyright for STMicroelectronics

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 1 +
 drivers/tty/serial/stm32-usart.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0338562..ebc49e4 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics SA 2017
  * Authors:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  *	     Gerald Baeza <gerald.baeza@st.com>
  * License terms:  GNU General Public License (GPL), version 2
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index cd97ceb..0532b2f 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics SA 2017
  * Authors:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  *	     Gerald Baeza <gerald_baeza@yahoo.fr>
  * License terms:  GNU General Public License (GPL), version 2
-- 
1.9.1
