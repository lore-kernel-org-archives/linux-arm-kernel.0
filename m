From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 15:18:09 +0100
Subject: [GIT PULL] Immutable branch between MFD, Input and RTC due for the
 v4.18 merge window
In-Reply-To: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
Message-ID: <20180416141809.34l2ofmeljqvyicm@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enjoy!

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-rtc-v4.18

for you to fetch changes up to 55d1d1547ab5e52269988af5e7c553796ff68e97:

  mfd: mt6397: Add PMIC keys support to MT6397 driver (2018-04-16 15:16:11 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Input and RTC due for the v4.18 merge window

----------------------------------------------------------------
Chen Zhong (5):
      mfd: mt6397: Create irq mappings in mfd core driver
      dt-bindings: input: Add document bindings for mtk-pmic-keys
      dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
      input: Add MediaTek PMIC keys support
      mfd: mt6397: Add PMIC keys support to MT6397 driver

 .../devicetree/bindings/input/mtk-pmic-keys.txt    |  43 +++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   6 +
 drivers/input/keyboard/Kconfig                     |   9 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/mtk-pmic-keys.c             | 339 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |  26 +-
 drivers/rtc/rtc-mt6397.c                           |   7 +-
 7 files changed, 424 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
