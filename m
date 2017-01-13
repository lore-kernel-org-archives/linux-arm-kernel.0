From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Jan 2017 18:11:28 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig64 for v4.11 (#1)
Message-ID: <871sw6996n.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig64 for mvebu for v4.11.

Gregory

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig64-4.11-1

for you to fetch changes up to 299d2f0238ec75bd13cc8c69a4cd6dbb9e7837be:

  arm64: defconfig: enable XORv2 for Marvell Armada 7K/8K (2017-01-03 16:38:51 +0100)

----------------------------------------------------------------
mvebu defconfig64 for 4.11 (part 1)

Update arm64 defconfig by adding XORv2 for Marvell Armada 7K/8K

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: defconfig: enable XORv2 for Marvell Armada 7K/8K

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
