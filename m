From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 30 Sep 2016 12:23:14 -0700
Subject: [GIT PULL 3/4] Broadcom defconfig changes for 4.9 (part 2)
In-Reply-To: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
References: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1475263395-27653-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/defconfig

for you to fetch changes up to ca2a92f87d9d8dc070f91f88ecd0f0d4c5f4dfad:

  ARM: multi_v7_defconfig: Enable BCM47xx/BCM5301x drivers (2016-09-30 11:53:55 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based defconfig changes for 4.9, please
pull the following:

- Florian updates the multi_v7_defconfig with the relevant basic drivers needed
  for the Broadcom BCM5301x (Northstar) SoCs to reboot, have PCIe, and Ethernet

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: multi_v7_defconfig: Enable BCM47xx/BCM5301x drivers

 arch/arm/configs/multi_v7_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)
