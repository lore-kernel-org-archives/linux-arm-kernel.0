From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Mon, 19 Nov 2018 12:03:30 +0100
Subject: [PATCH v2 0/2] SYSCFG Fast Mode Plus support for I2C STM32F7
Message-ID: <1542625412-4277-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append optional bindings to update SYSCFG Fast Mode Plus bits if
Fast Mode Plus speed is selected.

---
  Version history:
    v2:
       * solve some build issues
    v1:
       * Initial
---

Pierre-Yves MORDRET (2):
  dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus support for I2C STM32F7
  i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support for I2C STM32F7

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  6 ++++
 drivers/i2c/busses/i2c-stm32f7.c                   | 38 ++++++++++++++++++++--
 2 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.7.4
