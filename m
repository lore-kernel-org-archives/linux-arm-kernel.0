From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 20 Dec 2015 23:17:37 +0100
Subject: [GIT PULL] LPC18xx defconfig changes for v4.5
Message-ID: <1450649857-5639-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these defconfig changes for the NXP LPC18xx
platform into arm-soc/defconfig.

Defconfig updates for drivers on the LPC18xx platform devices and 
devices present on LPC18xx boards.

Sorry for the late pull request. Hope it's not too late.

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/manabian/linux-lpc.git tags/lpc18xx_defconfig_for_4.5

for you to fetch changes up to 74b40b2c53636290ac0ebee6c6c680aebd7e9347:

  ARM: configs: lpc18xx: enable EEPROM NVMEM driver (2015-12-14 22:49:11 +0100)

----------------------------------------------------------------
Defconfig additions for LPC18xx platform

Add LPC18xx EEPROM driver and MMA7455 IIO driver for the
accelerometer found on EA4357 Dev kit.

----------------------------------------------------------------
Ariel D'Alessandro (1):
      ARM: configs: lpc18xx: enable EEPROM NVMEM driver

Joachim Eastwood (1):
      ARM: configs: lpc18xx: enable mma7455 IIO driver

 arch/arm/configs/lpc18xx_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
