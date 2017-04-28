From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 28 Apr 2017 17:09:05 +0200
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.12 (#1)
Message-ID: <87fugs8t7y.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm64 for mvebu for v4.12.

It comes very late but the driver part has been merged just this week.

Gregory

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.12-1

for you to fetch changes up to d2718d1365f7fce624fd7ed163f60532f92ed016:

  arm64: marvell: enable the Armada 37xx pinctrl driver (2017-04-26 12:23:27 +0200)

----------------------------------------------------------------
mvebu arm64 for 4.12

enable the Armada 37xx pinctrl driver

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: marvell: enable the Armada 37xx pinctrl driver

 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)
