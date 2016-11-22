From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 Nov 2016 21:48:24 -0800
Subject: [GIT PULL 6/6] Broadcom defconfig-arm64 changes for 4.10
In-Reply-To: <20161122054824.16974-1-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
Message-ID: <20161122054824.16974-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.10/defconfig-arm64

for you to fetch changes up to 9efacfc80902c6ddf538a2f396e0112c1f6d1e23:

  Merge tag 'bcm2835-defconfig-64-next-2016-11-18' into defconfig-arm64/next (2016-11-21 21:22:55 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs defconfig changes for 4.10,
please pull the following changes:

- Eric updates the ARMv8 defconfig to contain everything that is needed to run
  a 64-bit kernel on the Raspberry Pi 3

- Scott enables the standard AT25 EEPROM driver as module for the ARM64 defconfig

- Martin enables the Raspberry Pi Thermal driver in the ARM64 defconfig

----------------------------------------------------------------
Eric Anholt (1):
      arm64: Add BCM2835 (Raspberry Pi 3) support to the defconfig

Florian Fainelli (2):
      Merge tag 'bcm2835-defconfig-64-next-2016-09-22' into defconfig-arm64/next
      Merge tag 'bcm2835-defconfig-64-next-2016-11-18' into defconfig-arm64/next

Martin Sperl (1):
      ARM64: bcm2835: add thermal driver to default config

Scott Branden (1):
      arm64: defconfig: enable EEPROM_AT25 config option

 arch/arm64/configs/defconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
