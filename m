From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 18:06:53 +0100
Subject: [GIT PULL] ARM: mvebu: soc for v4.11 (#1)
Message-ID: <87mvecwhxu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.11.

Gregory

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.11-1

for you to fetch changes up to f2591b993ec95fd8d67c68187f07f30c9d79b38c:

  soc: dove: constify reset_control_ops structures (2017-01-27 17:52:57 +0100)

----------------------------------------------------------------
mvebu soc for 4.11 (part 1)

Cleanup up on dove pmu and mv78x00 pci

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: mv78xx0: fix possible PCI buffer overflow

Bhumika Goyal (1):
      soc: dove: constify reset_control_ops structures

 arch/arm/mach-mv78xx0/pcie.c | 2 +-
 drivers/soc/dove/pmu.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
