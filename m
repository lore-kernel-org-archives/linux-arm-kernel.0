From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  9 Jul 2018 08:30:31 -0700
Subject: [GIT PULL 2/6] Broadcom defconfig-arm64 changes for 4.19
In-Reply-To: <20180709153035.6376-1-f.fainelli@gmail.com>
References: <20180709153035.6376-1-f.fainelli@gmail.com>
Message-ID: <20180709153035.6376-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/defconfig-arm64

for you to fetch changes up to ec93d5a25f9f959e6c20351e74182ad4bfa85716:

  Merge tag 'bcm2835-defconfig-64-next-2018-07-03' into defconfig-arm64/next (2018-07-09 05:23:47 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs defconfig changes
for 4.19, please pull the following changes:

- Stefan enables the Raspberry Pi voltage sensor driver (HWMON) in the
  arm64 defconfig file

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-64-next-2018-07-03' into defconfig-arm64/next

Stefan Wahren (1):
      arm64: defconfig: Enable RPi voltage sensor

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
