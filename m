From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 28 Oct 2016 12:30:38 +0100
Subject: [GIT PULL] ARM: dts: vexpress: fixes/updates for v4.10
Message-ID: <20161028113038.GD12241@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM Soc Team,

Please pull !

--
Regards,
Sudeep

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-dt-4.10

for you to fetch changes up to b01c3994817dc4e117c5642c3e09e0a231b5b477:

  ARM: dts: vexpress: add TC2 cpu capacity-dmips-mhz information (2016-10-17 17:05:58 +0100)

----------------------------------------------------------------
ARMv7 Vexpress DT fixes/updates for v4.10

1. Addition of CPU dmips/capacity information to TC2 platform

2. Cleanup/fix unit address warnings and removal of skeleton.dtsi from
   MPS2 device tree

----------------------------------------------------------------
Juri Lelli (1):
      ARM: dts: vexpress: add TC2 cpu capacity-dmips-mhz information

Vladimir Murzin (1):
      ARM: dts: mps2: remove skeleton.dtsi include and fix unit address warnings

 arch/arm/boot/dts/mps2-an385.dts           | 2 +-
 arch/arm/boot/dts/mps2-an399.dts           | 2 +-
 arch/arm/boot/dts/mps2.dtsi                | 4 +++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 5 +++++
 4 files changed, 10 insertions(+), 3 deletions(-)
