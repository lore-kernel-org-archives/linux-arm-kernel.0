From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:58:06 -0700
Subject: [GIT PULL 6/7] Broadcom defconfig-arm64 changes for 4.12
In-Reply-To: <20170324175807.27272-1-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
Message-ID: <20170324175807.27272-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/defconfig-arm64

for you to fetch changes up to 1aaf0f47350ef912dd65d58cd94d4976b02e78c7:

  Merge tag 'bcm2835-defconfig-64-next-2017-03-21' into defconfig-arm64/next (2017-03-24 10:14:14 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs defconfig updates for
4.12, please pull the following:

- Gerd enables the BCM2835 MMC driver which yields better performance than the
  default one (iProc)

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-64-next-2017-03-21' into defconfig-arm64/next

Gerd Hoffmann (1):
      arm64: set CONFIG_MMC_BCM2835=y in defconfig

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
