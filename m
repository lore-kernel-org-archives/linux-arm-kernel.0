From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 5 Jul 2016 15:40:14 +0200
Subject: [PATCH 0/3] Add STM32F746 MCU pinctrl support
Message-ID: <1467726017-20041-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds STM32F746 pinctrl and GPIO support, relies on the
generic STM32 pinctrl driver.

Regards

Alex

Alexandre TORGUE (2):
  includes: dt-bindings: Add STM32F746 pinctrl DT bindings
  Documentation: dt: Add new compatible to STM32 pinctrl driver bindings

Maxime Coquelin (1):
  pinctrl: Add STM32F746 MCU support

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    1 +
 drivers/pinctrl/stm32/Kconfig                      |    6 +
 drivers/pinctrl/stm32/Makefile                     |    2 +
 drivers/pinctrl/stm32/pinctrl-stm32f746.c          | 1693 ++++++++++++++++++++
 include/dt-bindings/pinctrl/stm32f746-pinfunc.h    | 1335 +++++++++++++++
 5 files changed, 3037 insertions(+)
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f746.c
 create mode 100644 include/dt-bindings/pinctrl/stm32f746-pinfunc.h

-- 
1.9.1
