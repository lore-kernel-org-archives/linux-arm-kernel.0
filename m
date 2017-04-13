From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 13 Apr 2017 18:25:28 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig64 for v4.12 (#2)
Message-ID: <871ssww9zb.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for defconfig64 for mvebu for v4.12.
There is a trivial merge conflict already solved by Stephen Rothwell
there:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/500998.html

Gregory

The following changes since commit 66e56302842e9971426bd7e504c4db4f88cbb037:

  arm64: defconfig: enable MVPP2 (2017-03-23 17:50:13 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig64-4.12-2

for you to fetch changes up to 10ebb57ffcbf062ff224585fefa274e703fc363d:

  arm64: defconfig: enable the Safexcel crypto engine as a module (2017-04-12 15:35:16 +0200)

----------------------------------------------------------------
mvebu defconfig64 for 4.12 (part 2)

Select two new drivers  for ARM64 mvebu SoCs:
 - Xenon SDHCI controller on Armada 37xx and Armada 7K/8K
 - Safexcel crypto engine on Armada 7K/8K

----------------------------------------------------------------
Antoine Tenart (1):
      arm64: defconfig: enable the Safexcel crypto engine as a module

Gregory CLEMENT (1):
      arm64: configs: enable SDHCI driver for Xenon

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
