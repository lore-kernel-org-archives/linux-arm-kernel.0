From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 6 Jul 2016 11:46:57 +0200
Subject: [PATCH v2] Add STM32F746 MCU pinctrl support
Message-ID: <1467798418-12124-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds STM32F746 pinctrl and GPIO support, relies on the
generic STM32 pinctrl driver.

I only send a V2 for this patch as others have already been taken by Linus in
V1.

Changes since v1:

Thanks to Paul Gortmaker remarks, remove all modular API as this driver is only
built-in one.

Regards

Alex

Alexandre TORGUE (1):
  pinctrl: Add STM32F746 MCU support

 drivers/pinctrl/stm32/Kconfig             |    6 +
 drivers/pinctrl/stm32/Makefile            |    2 +
 drivers/pinctrl/stm32/pinctrl-stm32f746.c | 1686 +++++++++++++++++++++++++++++
 3 files changed, 1694 insertions(+)
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f746.c

-- 
1.9.1
