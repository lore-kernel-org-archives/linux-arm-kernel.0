From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 20 Apr 2017 17:30:29 +0100
Subject: [GIT PULL] ARM: dts: vexpress: fix for v4.12
Message-ID: <3457b9e7-f720-b142-fa82-2855b2c2e2b1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC team,

Sorry for the late pull request, but this just contain fix to remove DT
build warnings that are showing up in linux-next

Please pull!

Regards,
Sudeep

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/vexpress-dt-4.12

for you to fetch changes up to e6a7efad7921f12ea8112f16681e47fb30c7d975:

  ARM: dts: vexpress: fix few unit address format warnings (2017-04-19
12:08:37 +0100)

----------------------------------------------------------------
ARMv7 VExpress DT fix for v4.12

A single fix to remove device tree warnings introduced with recently
added checks in DTC

----------------------------------------------------------------
Sudeep Holla (1):
      ARM: dts: vexpress: fix few unit address format warnings

 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     | 24 +++++++---------
 arch/arm/boot/dts/vexpress-v2m.dtsi         | 24 +++++++---------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |  2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  | 18 +++++++-------
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |  2 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      |  2 +-
 6 files changed, 36 insertions(+), 36 deletions(-)
