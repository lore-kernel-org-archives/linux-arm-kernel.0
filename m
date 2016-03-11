From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 11 Mar 2016 07:09:08 +0700
Subject: [PATCH v2 0/3] Enable configs for 96boards HiKey and general arm64
Message-ID: <1457654951-29944-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables a number of devices currently supported by the Hi6220
and 96boards HiKey. These include
a) Hi655x PMIC and regulator
b) Hi6220 I2C, USB, MMC, mailbox, and reset
c) CONFIG_PINCTRL_SINGLE, and CONFIG_LEDS_GPIO

Also added general features required in arm64:
 - SPIDEV
 - USB network adapters

v2:
 - rebase to next-20160310, CONFIG_MMC_BLOCK_MINORS=16 is already in.
 - set CONFIG_I2C_DESIGNWARE_PLATFORM to be build as module
 - Add general features for arm64

Akira Tsukamoto (1):
  ARM64: defconfig: enable several common USB network adapters

Guodong Xu (2):
  arm64: defconfig: Enable devices for Hi6220 and 96boards HiKey
  arm64: defconfig: add CONFIG_SPI_SPIDEV as module

 arch/arm64/configs/defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
1.9.1
