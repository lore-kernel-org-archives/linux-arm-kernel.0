From: eric@anholt.net (Eric Anholt)
Date: Tue,  3 Jul 2018 13:05:11 -0700
Subject: [GIT PULL 4/4] bcm2835-defconfig-64-next-2018-07-03
In-Reply-To: <20180703200511.2725-1-eric@anholt.net>
References: <20180703200511.2725-1-eric@anholt.net>
Message-ID: <20180703200511.2725-4-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-64-next-2018-07-03

for you to fetch changes up to 79db60a8bb0b32fdda90a338f09fc83d7d576abe:

  arm64: defconfig: Enable RPi voltage sensor (2018-06-21 17:31:19 -0700)

----------------------------------------------------------------
This pull request enables the new RPi HWMON driver in the 64-bit
defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      arm64: defconfig: Enable RPi voltage sensor

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
