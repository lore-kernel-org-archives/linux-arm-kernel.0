From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  5 Sep 2018 12:02:59 -0700
Subject: [GIT PULL 1/1] Broadcom drivers fixes for 4.19
Message-ID: <20180905190259.29303-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/drivers-fixes

for you to fetch changes up to d07f05fb86439c41dd6967c94be3ba3837b21567:

  hwmon: rpi: add module alias to raspberrypi-hwmon (2018-09-05 11:58:00 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM/ARM64 SoCs drivers fixes for
4.19, please pull the following:

- Peter adds an alias to the Raspberry Pi HWMON driver that was just
  merged as part of the 4.19 merge window

----------------------------------------------------------------
Peter Robinson (1):
      hwmon: rpi: add module alias to raspberrypi-hwmon

 drivers/hwmon/raspberrypi-hwmon.c | 1 +
 1 file changed, 1 insertion(+)
