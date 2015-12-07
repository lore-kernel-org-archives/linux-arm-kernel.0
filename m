From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon,  7 Dec 2015 10:56:03 +0000
Subject: [PATCH 0/4] nvmem: new drivers for v4.5
Message-ID: <1449485763-391-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here are 2 new nvmem drivers which are in the mailing list for long time
and are good to go for some testing and find its way to v4.5-rc*.

Could you please take these patches via char-misc tree.

Thanks,
srini

Andrew-CT Chen (2):
  dt-bindings: add document of mediatek efuse driver
  nvmem: mediatek: Add Mediatek EFUSE driver

Ariel D'Alessandro (2):
  DT: nvmem: Add NXP LPC18xx EEPROM memory binding documentation
  nvmem: NXP LPC18xx EEPROM memory NVMEM driver

 .../devicetree/bindings/nvmem/lpc1857-eeprom.txt   |  28 ++
 .../devicetree/bindings/nvmem/mtk-efuse.txt        |  36 +++
 drivers/nvmem/Kconfig                              |  20 ++
 drivers/nvmem/Makefile                             |   4 +
 drivers/nvmem/lpc18xx_eeprom.c                     | 330 +++++++++++++++++++++
 drivers/nvmem/mtk-efuse.c                          |  89 ++++++
 6 files changed, 507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
 create mode 100644 drivers/nvmem/lpc18xx_eeprom.c
 create mode 100644 drivers/nvmem/mtk-efuse.c

-- 
1.9.1
