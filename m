From: lionel.debieve@st.com (Lionel Debieve)
Date: Tue, 26 Jun 2018 14:52:43 +0200
Subject: [PATCH 0/3] crypto: stm32 - Add power mamagement support
Message-ID: <1530017566-14779-1-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches add pm and pm_runtime feature to stm32 crypto
drivers.

Lionel Debieve (3):
  crypto: stm32/cryp - Add power management support
  crypto: stm32/hash - Add power management support
  crypto: stm32/crc - Add power management support

 drivers/crypto/stm32/stm32-cryp.c  | 62 +++++++++++++++++++++++++++++++++
 drivers/crypto/stm32/stm32-hash.c  | 71 ++++++++++++++++++++++++++++++++++++++
 drivers/crypto/stm32/stm32_crc32.c | 62 +++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

-- 
2.7.4
