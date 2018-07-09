From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  9 Jul 2018 08:30:30 -0700
Subject: [GIT PULL 1/6] Broadcom defconfig changes for 4.19
Message-ID: <20180709153035.6376-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/defconfig

for you to fetch changes up to b0ba9fad81e419f85829c2a6925110d9714dd708:

  Merge tag 'bcm2835-defconfig-next-2018-07-03' into defconfig/next (2018-07-09 05:23:16 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs defconfig updates
for 4.19, please pull the following:

- Stefan enables the Raspberry Pi voltage sensor driver (HWMON) in both
  multi_v7_defconfig and bcm2835_defconfig

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2018-07-03' into defconfig/next

Stefan Wahren (2):
      ARM: bcm2835_defconfig: Enable RPi voltage sensor
      ARM: multi_v7_defconfig: Enable RPi voltage sensor

 arch/arm/configs/bcm2835_defconfig  | 2 +-
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
