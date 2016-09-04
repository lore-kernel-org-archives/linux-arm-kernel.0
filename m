From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 04 Sep 2016 17:56:45 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig64 for v4.9 (#1)
Message-ID: <87k2erzmiq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig64 for mvebu for v4.9.

Gregory

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig64-4.9-1

for you to fetch changes up to cfa1c7c8af9fe956d446a7d5b8ed3a895496884c:

  arm64: configs: enable PCIe driver for Aardvark (2016-08-26 11:03:04 +0200)

----------------------------------------------------------------
mvebu defconfig64 for 4.9 (part 1)

- add PCIe driver for Aardvark for Armada 3700
- enable xhci-platform for A7K/A8K

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: configs: enable PCIe driver for Aardvark

Thomas Petazzoni (1):
      arm64: defconfig: enable xhci-platform

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
