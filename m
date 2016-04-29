From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 16:34:24 +0200
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.7 (#1)
Message-ID: <87shy4scun.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm64 for mvebu for v4.7.

Gregory

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.7-1

for you to fetch changes up to 1f664ab7d9d46abdcde294e3e6e9d5d98a2e6f73:

  MAINTAINERS: update entry for Marvell ARM platform maintainers (2016-04-26 15:18:48 +0200)

----------------------------------------------------------------
mvebu arm64 for 4.7

- Mention the arm64 SoCs in the MAINTAINER file
- Enable syscon drivers for Marvell Armada 7K/8K (replacing the clk
  one)

----------------------------------------------------------------
Thomas Petazzoni (2):
      arm64: marvell: enable AP806 and CP110 syscon driver
      MAINTAINERS: update entry for Marvell ARM platform maintainers

 MAINTAINERS                  | 2 +-
 arch/arm64/Kconfig.platforms | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
