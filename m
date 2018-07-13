From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Jul 2018 07:38:17 -0700
Subject: [GIT PULL 2/6 v2] Broadcom defconfig-arm64 changes for 4.19
In-Reply-To: <20180713143821.1514-1-f.fainelli@gmail.com>
References: <20180713143821.1514-1-f.fainelli@gmail.com>
Message-ID: <20180713143821.1514-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/defconfig-arm64

for you to fetch changes up to 163efb68d110d392b54e078ca041f24a4ea7d022:

  arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG (2018-07-09 10:40:23 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs defconfig changes
for 4.19, please pull the following changes:

- Stefan enables the Raspberry Pi voltage sensor driver (HWMON) in the
  arm64 defconfig file

- Ray enables the ARM SP805 watchdog driver in the arm64 defconfig file

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-64-next-2018-07-03' into defconfig-arm64/next

Ray Jui (1):
      arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

Stefan Wahren (1):
      arm64: defconfig: Enable RPi voltage sensor

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
