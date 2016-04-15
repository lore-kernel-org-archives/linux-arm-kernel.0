From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 15 Apr 2016 18:50:48 +0100
Subject: [GIT PULL] arm64: dts: juno: DT updates for v4.7
Message-ID: <571129F8.3040609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Just one minor update for Juno DT, please pull !

--
Regards,
Sudeep

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/juno-for-v4.7/dt-updates

for you to fetch changes up to f5f7e45537e4ff534436c00d5671c1df84b0c390:

   arm64: dts: juno: Add external expansion bus to DT (2016-04-15 
09:50:06 +0100)

----------------------------------------------------------------
ARMv8 Juno DT updates for v4.7

Just one update: Support for external expansion bus useful for
additional hardware e.g.LogicTile Express daughterboards (Brian Starkey)

----------------------------------------------------------------
Brian Starkey (1):
       arm64: dts: juno: Add external expansion bus to DT

  arch/arm64/boot/dts/arm/juno-base.dtsi | 10 ++++++++++
  1 file changed, 10 insertions(+)
