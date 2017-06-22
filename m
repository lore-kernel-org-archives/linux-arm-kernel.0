From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Jun 2017 14:26:52 +0200
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.13 (#1)
Message-ID: <8760fo1a43.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm64 for mvebu for v4.13.

Gregory

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.13-1

for you to fetch changes up to 29ad6bd9ada2629fe1b7b30d6d08259005abcb8a:

  arm64: marvell: enable ICU and GICP drivers (2017-06-21 17:47:17 +0200)

----------------------------------------------------------------
mvebu arm64 for 4.13 (part 1)

- enable the ICU and GICP drivers for Armada 7K/8K
- enable the pinctrl driver for Armada 7K/8K

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: marvell: enable the Armada 7K/8K pinctrl driver

Thomas Petazzoni (1):
      arm64: marvell: enable ICU and GICP drivers

 arch/arm64/Kconfig.platforms | 4 ++++
 1 file changed, 4 insertions(+)
