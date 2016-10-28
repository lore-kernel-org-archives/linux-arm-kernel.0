From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 28 Oct 2016 12:31:04 +0100
Subject: [GIT PULL] arm64: dts: juno: updates for v4.10
Message-ID: <20161028113104.GE12241@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull.

--
Regards,
Sudeep

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-dt-4.10

for you to fetch changes up to c1ab65b24065ab04bdb0bc4e89d88784d38dc644:

  arm64: dts: juno: add cpu capacity-dmips-mhz information to R2 boards (2016-10-17 17:43:22 +0100)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT updates for v4.10

1. Addition of SMMU(MMU-401) device nodes mainly to assist other
   developments and testing

2. Addition of CPU dmips/capacity information on all the Juno boards

----------------------------------------------------------------
Juri Lelli (3):
      arm64: dts: juno: add cpu capacity-dmips-mhz information to R0 boards
      arm64: dts: juno: add cpu capacity-dmips-mhz information to R1 boards
      arm64: dts: juno: add cpu capacity-dmips-mhz information to R2 boards

Robin Murphy (1):
      arm64: dts: juno: Add SMMUs device nodes

 arch/arm64/boot/dts/arm/juno-base.dtsi | 80 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    |  6 +++
 arch/arm64/boot/dts/arm/juno-r2.dts    |  6 +++
 arch/arm64/boot/dts/arm/juno.dts       |  6 +++
 4 files changed, 98 insertions(+)
