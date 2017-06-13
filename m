From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Jun 2017 13:10:38 -0700
Subject: [GIT PULL 1/7] Broadcom soc changes for 4.13 (v2)
Message-ID: <20170613201044.9808-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/soc

for you to fetch changes up to 27d9fa06c122b135ad7552fa3138c3b47e5776c5:

  ARM: BCM: Enable thermal support for NSP SoCs (2017-05-19 11:30:25 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs (non Device Tree) changes:

- Jon updates the Kconfig entry for Northstar Plus to have THERMAL and THERMAL_OF
  selected in order to get the NS/NSP thermal driver dependencies to be satistfied

----------------------------------------------------------------
Jon Mason (1):
      ARM: BCM: Enable thermal support for NSP SoCs

 arch/arm/mach-bcm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
