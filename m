From: bich.hemon@st.com (Bich HEMON)
Date: Wed, 28 Feb 2018 10:51:16 +0000
Subject: [PATCH 0/2] Update interrupt names
Message-ID: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates existing stm32 usart driver by updating interrupt
initialization by name.

Bich Hemon (2):
  dt-bindings: serial: stm32: add wakeup option using note
  serial: stm32: update interrupt initialization

 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
 drivers/tty/serial/stm32-usart.c                            | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.9.1
