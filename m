From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 18 Sep 2018 12:17:53 +0100
Subject: [GIT PULL] arm64: dts: juno: updates for v4.20
Message-ID: <20180918111752.GB23868@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

Regards,
Sudeep

--

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-updates-4.20

for you to fetch changes up to 79daf2a4089f6a817e5e0202362cdc764b535561:

  arm64: dts: juno: Enable coresight tmc scatter gather in ETR (2018-09-11 11:41:28 +0100)

----------------------------------------------------------------
ARMv8 Juno/Vexpress updates for v4.20

1. Enablement of scatter gather mode for CoreSight TMC-ETR routing

2. Usage of updated coresight graph bindings that eliminates loads of
   dtc warnings

----------------------------------------------------------------
Suzuki K Poulose (2):
      arm64: dts: juno: Update entries to match latest coresight bindings
      arm64: dts: juno: Enable coresight tmc scatter gather in ETR

 arch/arm64/boot/dts/arm/juno-base.dtsi    | 162 +++++++++++++++---------------
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  52 ++++------
 arch/arm64/boot/dts/arm/juno.dts          |  13 +--
 3 files changed, 106 insertions(+), 121 deletions(-)
