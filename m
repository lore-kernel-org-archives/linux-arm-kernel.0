From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Mar 2018 12:52:59 -0700
Subject: [GIT PULL 2/2] Broadcom defconfig changes for 4.17
In-Reply-To: <20180313195259.20496-1-f.fainelli@gmail.com>
References: <20180313195259.20496-1-f.fainelli@gmail.com>
Message-ID: <20180313195259.20496-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.17/defconfig

for you to fetch changes up to 437fe668ab5ecdfd312605b0da15cf9138101d3f:

  Merge tag 'bcm2835-defconfig-next-2018-02-28' into defconfig/next (2018-02-28 15:36:51 -0800)

----------------------------------------------------------------
This pull request contains multi_v7_defconfig changes for Broadcom
ARM-based SoC for 4.17, please pull the following:

- Tuomas enables the BCM2835 AUX driver which is necessary to provide
  console on the Raspberry Pi 3

- Stefan turns on support for the BCM43438 Bluetooth adapter connected
  via UART on the Raspberry Pi Zero Wireless and he also turns on
  support for the thermal driver on the Pi 2 and 3.

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2018-02-28' into defconfig/next

Stefan Wahren (2):
      ARM: bcm2385_defconfig: Enable BT support for BCM43438
      ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3

Tuomas Tynkkynen (1):
      ARM: multi_v7_defconfig: Enable serial console on RPi 3

 arch/arm/configs/bcm2835_defconfig  | 4 ++++
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 2 files changed, 8 insertions(+)
