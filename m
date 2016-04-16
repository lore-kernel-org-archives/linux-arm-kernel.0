From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 16 Apr 2016 12:16:05 +0100
Subject: [GIT PULL]Hisilicon ARM64 Hi6220 SoC defconfig updates for 4.7
Message-ID: <57121EF5.3060302@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hi6220-config-for-4.7

for you to fetch changes up to fd2112eb018daf053fccec785c8dc319be760499:

  arm64: defconfig: enable configs for WLAN and TI WL1835 as modules (2016-04-15 17:36:52 +0100)

----------------------------------------------------------------
ARM64: Hi6220: configure updates for 4.7

- Enable Hi655x PMIC and regulator
- Enable Hi6220 I2C, USB, MMC, mailbox and reset
- Enable PINCTRL_SINGLE and LEDS_GPIO
- Enable SPI_SPIDEV as module
- Enable several common USB-Ethernet dongles
- Enable configs for WLAN and TI WL1835 as modules

----------------------------------------------------------------
Akira Tsukamoto (1):
      arm64: defconfig: enable several common USB network adapters

Guodong Xu (3):
      arm64: defconfig: Enable devices for Hi6220 and 96boards HiKey
      arm64: defconfig: add CONFIG_SPI_SPIDEV as module
      arm64: defconfig: enable configs for WLAN and TI WL1835 as modules

 arch/arm64/configs/defconfig | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)
