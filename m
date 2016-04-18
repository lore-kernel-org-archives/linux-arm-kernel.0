From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 18 Apr 2016 16:08:26 +0100
Subject: [GIT PULL v2] arm64: hisilicon: config changes for 4.7
Message-ID: <5714F86A.40001@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.

I based this pull request on v4.6-rc4 instead of rc1 to avoid the
duplication that some configurations have been enabled.

Thanks!

Best Regards,
Wei

---

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hi6220-config-for-4.7v2

for you to fetch changes up to 00e0662b50cde2caa3cb421712a85a300b3de0f0:

  arm64: Kconfig: select sp804 timer for ARCH_HISI (2016-04-18 14:57:02 +0100)

----------------------------------------------------------------
ARM64: Hi6220: configure updates for 4.7

- Enable Hi655x PMIC and regulator
- Enable SPI_SPIDEV as module
- Enable several common USB-Ethernet dongles
- Enable configs for WLAN and TI WL1835 as modules
- Enable ARM SP804 for ARCH_HISI

----------------------------------------------------------------
Akira Tsukamoto (1):
      arm64: defconfig: enable several common USB network adapters

Guodong Xu (3):
      arm64: defconfig: Enable devices for Hi6220 and 96boards HiKey
      arm64: defconfig: add CONFIG_SPI_SPIDEV as module
      arm64: defconfig: enable configs for WLAN and TI WL1835 as modules

Leo Yan (1):
      arm64: Kconfig: select sp804 timer for ARCH_HISI

 arch/arm64/Kconfig.platforms |  1 +
 arch/arm64/configs/defconfig | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)
