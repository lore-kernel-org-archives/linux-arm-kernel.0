From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 Nov 2016 21:48:23 -0800
Subject: [GIT PULL 5/6] Broadcom defconfig changes for 4.10
In-Reply-To: <20161122054824.16974-1-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
Message-ID: <20161122054824.16974-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.10/defconfig

for you to fetch changes up to 33c037c51be5df857ae563f7fc551dc6e746d9de:

  Merge tag 'bcm2835-defconfig-next-2016-11-18' into defconfig/next (2016-11-21 21:20:15 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based defconfig changes for 4.10, please
pull the following:

- Florian updates the multi_v7_defconfig with the relevant basic drivers needed
  for the Broadcom BCM5301x (Northstar) SoCs to reboot, have PCIe, and Ethernet

- Martin enables the Raspberry Pi thermal driver in bcm2835_defconfig

----------------------------------------------------------------
Florian Fainelli (2):
      ARM: multi_v7_defconfig: Enable BCM47xx/BCM5301x drivers
      Merge tag 'bcm2835-defconfig-next-2016-11-18' into defconfig/next

Martin Sperl (1):
      ARM: bcm2835: add thermal driver to default config

 arch/arm/configs/bcm2835_defconfig  |  2 ++
 arch/arm/configs/multi_v7_defconfig | 13 +++++++++++++
 2 files changed, 15 insertions(+)
