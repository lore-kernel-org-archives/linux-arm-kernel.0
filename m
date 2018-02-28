From: bich.hemon@st.com (Bich HEMON)
Date: Wed, 28 Feb 2018 10:56:18 +0000
Subject: [PATCH 0/2] Add support for RS485
Message-ID: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates existing stm32 usart driver by adding support for RS485.

Bich Hemon (2):
  dt-bindings: serial: stm32: add RS485 optional properties
  serial: stm32: add support for RS485 hardware control mode

 .../devicetree/bindings/serial/st,stm32-usart.txt  |   2 +
 drivers/tty/serial/stm32-usart.c                   | 134 ++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h                   |   3 +
 3 files changed, 138 insertions(+), 1 deletion(-)

-- 
1.9.1
