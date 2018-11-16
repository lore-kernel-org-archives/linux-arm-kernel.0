From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 13:20:20 +0100
Subject: [PATCH v1 0/2] SYSCFG Fast Mode Plus support for I2C STM32F7
Message-ID: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append optional bindings to update SYSCFG Fast Mode Plus bits if
Fast Mode Plus speed is selected.

---
  Version history:
    v1:
       * Initial
---

Pierre-Yves MORDRET (2):
  dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus support for I2C STM32F7
  i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support for I2C STM32F7

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  6 ++++
 drivers/i2c/busses/i2c-stm32f7.c                   | 37 ++++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.7.4
