From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jul 2018 14:57:35 +0200
Subject: [PATCH 0/2] STM32 pinctrl updates
Message-ID: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

This series includes two updates for stm32 pinctrl driver:

 -Fixes the way to map a gpio bank to an EXTi line.
 -Check "status" devicetree entry (in gpio-contriller node) before registering
  a new gpio bank.

Regards
Alex

Alexandre Torgue (2):
  pinctrl: stm32: fix bank io port number
  pinctrl: stm32: check node status before new gpio bank registering

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |  2 ++
 drivers/pinctrl/stm32/pinctrl-stm32.c              | 27 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.7.4
