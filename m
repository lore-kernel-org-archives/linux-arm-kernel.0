From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat,  2 Apr 2016 19:47:50 +0800
Subject: [PATCH v3 0/4] Enable configs for 96boards HiKey and general arm64
Message-ID: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables a number of devices currently supported by the Hi6220
and 96boards HiKey. These include
a) Hi655x PMIC and regulator
b) Hi6220 I2C, USB, MMC, mailbox, and hisi-reset
c) CONFIG_PINCTRL_SINGLE, and CONFIG_LEDS_GPIO
d) WLAN, TI WL1835

Also added general features (built as modules) in arm64:
 - SPIDEV
 - USB network adapters

v3:
 - rebase to next-20160401
 - Enabled configs for WLAN and TI WL1835.

v2:
 - rebase to next-20160310, CONFIG_MMC_BLOCK_MINORS=16 is already in.
 - set CONFIG_I2C_DESIGNWARE_PLATFORM to be build as module
 - Enable general features (as modules) in arm64

Akira Tsukamoto (1):
  arm64: defconfig: enable several common USB network adapters

Guodong Xu (3):
  arm64: defconfig: Enable devices for Hi6220 and 96boards HiKey
  arm64: defconfig: add CONFIG_SPI_SPIDEV as module
  arm64: defconfig: enable configs for WLAN and TI WL1835 as modules

 arch/arm64/configs/defconfig | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

-- 
1.9.1
