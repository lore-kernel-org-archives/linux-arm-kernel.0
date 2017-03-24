From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:58:05 -0700
Subject: [GIT PULL 5/7] Broadcom defconfig changes for 4.12
In-Reply-To: <20170324175807.27272-1-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
Message-ID: <20170324175807.27272-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/defconfig

for you to fetch changes up to f880c8fd8cfb3bcb77a219c00de45ad0a8386d23:

  Merge tag 'bcm2835-defconfig-next-2017-03-21' into defconfig/next (2017-03-24 10:13:25 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs defconfig updates for 4.12,
please pull the following:

- Gerd enables the BCM2835 MMC driver which yields better performance than the
  default one (iProc)

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2017-03-21' into defconfig/next

Gerd Hoffmann (1):
      arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig and multi_v7_defconfig

Stefan Wahren (1):
      ARM: bcm2835: Enable missing CMA settings for VC4 driver

 arch/arm/configs/bcm2835_defconfig  | 5 +++--
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
