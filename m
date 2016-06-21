From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Jun 2016 11:11:58 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig64 for v4.8 (#1)
Message-ID: <87twgm9a8x.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig64 for mvebu for v4.8.

Gregory

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig64-4.8-1

for you to fetch changes up to 4cf28937cac21f90cacc9477e917d90c2d9ff0b3:

  arm64: configs: enable PCIe driver for Armada 7K/8K (2016-06-16 17:08:50 +0200)

----------------------------------------------------------------
mvebu defconfig64 for 4.8 (part 1)

- Enable the PCIe host controller found on the Armada 7K/8K SoCs

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: configs: enable PCIe driver for Armada 7K/8K

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
