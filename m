From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Jun 2016 11:10:10 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.7 (#1)
Message-ID: <87wpli9abx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.7.

Gregory

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.7-1

for you to fetch changes up to 929e604efa3dc0522214e0dc18984be23993e9f0:

  ARM: dts: armada-38x: fix MBUS_ID for crypto SRAM on Armada 385 Linksys (2016-06-16 17:01:28 +0200)

----------------------------------------------------------------
mvebu fixes for 4.7 (part 1)

Various I/O memory fix for Cortex A9 based SoCs

----------------------------------------------------------------
Thomas Petazzoni (3):
      ARM: mvebu: fix HW I/O coherency related deadlocks
      ARM: mvebu: map PCI I/O regions strongly ordered
      ARM: dts: armada-38x: fix MBUS_ID for crypto SRAM on Armada 385 Linksys

 arch/arm/boot/dts/armada-385-linksys.dtsi |  4 ++--
 arch/arm/mach-mvebu/coherency.c           | 23 +++++++++--------------
 2 files changed, 11 insertions(+), 16 deletions(-)
