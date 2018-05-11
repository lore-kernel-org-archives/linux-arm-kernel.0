From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 11 May 2018 14:43:35 -0700
Subject: [GIT PULL 2/5] Broadcom defconfig-arm64 changes for 4.18
In-Reply-To: <20180511214339.24139-1-f.fainelli@gmail.com>
References: <20180511214339.24139-1-f.fainelli@gmail.com>
Message-ID: <20180511214339.24139-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/defconfig-arm64

for you to fetch changes up to dce4c94eedbd35cd63aa04ee9b022de6d23ee587:

  Merge tag 'bcm2835-defconfig-64-next-2018-04-30' into defconfig-arm64/next (2018-05-01 11:54:16 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs defconfig changes
for 4.18, please pull the following:

- Stefan provides a set of updates targeting the Raspberry Pi 3 B+
  platform: LAN7515 USB Ethernet driver, Cypress CYW43455 Bluetooth when
  using the Pi 3 B+ in AArch64 boot mode.

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-64-next-2018-04-30' into defconfig-arm64/next

Stefan Wahren (1):
      arm64: defconfig: Enable LAN and BT support for RPi 3 B+

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
