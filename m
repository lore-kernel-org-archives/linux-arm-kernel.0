From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 17 Jun 2017 08:46:29 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.13 (#1)
Message-ID: <87shiz5cxm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig for mvebu for v4.13.

Gregory

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.13-1

for you to fetch changes up to 4cdcf1efcc2623c7a5358d38d71aecc8bed32b7e:

  ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig (2017-06-17 08:14:10 +0200)

----------------------------------------------------------------
mvebu defconfig for 4.13

Enable the SENSORS_PWM_FAN in mvebu_v7_defconfig support by gpio
driver since the previous release

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig

 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)
