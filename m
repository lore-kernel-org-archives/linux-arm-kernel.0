From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 25 Apr 2016 17:31:16 +0100
Subject: [GIT PULL v2 2/2] ARM: vexpress: Updates for v4.7
In-Reply-To: <1461601876-25288-1-git-send-email-sudeep.holla@arm.com>
References: <1461601876-25288-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1461601876-25288-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-for-v4.7/updates

for you to fetch changes up to 2b4e38fd7c12d37ee1887834eb45ae30b5e8f4e3:

  ARM: dts: vexpress: Add external expansion bus to DT (2016-04-25 11:01:14 +0100)

----------------------------------------------------------------
ARMv7 Vexpress updates/fixes for v4.7

1. Support for external expansion bus useful for additional hardware
   e.g. LogicTile Express daughterboards (Brian Starkey)

2. Fix for device node name unit-address presence/absence warnings
   enabled in recently update DTC (Sudeep Holla)

----------------------------------------------------------------
Brian Starkey (1):
      ARM: dts: vexpress: Add external expansion bus to DT

Sudeep Holla (1):
      ARM: dts: vexpress: fix node name unit-address presence warnings

 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     | 44 +++++++++++-----------
 arch/arm/boot/dts/vexpress-v2m.dtsi         | 44 +++++++++++-----------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts | 47 +++++++++++++++---------
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  | 57 ++++++++++++++++++-----------
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     | 37 +++++++++++++------
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      | 41 ++++++++++++++-------
 6 files changed, 161 insertions(+), 109 deletions(-)
