From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 16 Jan 2017 16:22:06 +0000
Subject: [GIT PULL] arm64: dts: juno: updates for v4.11
Message-ID: <dbfa1905-d937-7d02-7bbb-5f1a127896cf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/juno-updates-4.11

for you to fetch changes up to ea2dcf9ac3254c964cddd67a032cb3b691fa47ce:

  arm64: dts: juno: add missing CoreSight STM component (2017-01-12
17:26:49 +0000)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT updates for v4.11

1. Addition of Coresight support on Juno R1 and R2 variants

2. Addition of STM(System Trace Macrocell) support on all Juno variants

----------------------------------------------------------------
Mike Leach (2):
      arm64: dts: juno: fix CoreSight support for Juno r1/r2 variants
      arm64: dts: juno: add missing CoreSight STM component

Sudeep Holla (1):
      arm64: dts: juno: refactor CoreSight support on Juno r0

 arch/arm64/boot/dts/arm/juno-base.dtsi    | 31 +++++++---
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 98
+++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts       | 13 ++++
 arch/arm64/boot/dts/arm/juno-r2.dts       | 13 ++++
 arch/arm64/boot/dts/arm/juno.dts          | 24 ++++++++
 5 files changed, 171 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
