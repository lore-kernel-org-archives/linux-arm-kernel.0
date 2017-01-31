From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Jan 2017 15:08:12 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.10 (#1)
Message-ID: <87y3xrz5ir.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.10.

Initially I applied them on mvebu/dt byt finally they looked more
appropriate for fixes.

Gregory

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.10-1

for you to fetch changes up to 6cfd3cd8d8365cf78db1d25cd276d3d900eb8541:

  ARM: dts: orion5x-lschl: More consistent naming on linkstation series (2017-01-31 12:19:33 +0100)

----------------------------------------------------------------
mvebu fixes for 4.10 (part 1)

More consistent naming for some orion5x based boards helping the
switch to device tree for debian users.

----------------------------------------------------------------
Roger Shimizu (2):
      ARM: dts: orion5x-lschl: Fix model name
      ARM: dts: orion5x-lschl: More consistent naming on linkstation series

 .../arm/boot/dts/{orion5x-lschl.dts => orion5x-linkstation-lschl.dts} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{orion5x-lschl.dts => orion5x-linkstation-lschl.dts} (98%)
