From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 20 Apr 2017 17:30:51 +0100
Subject: [GIT PULL] arm64: dts: juno: fixes for v4.12
Message-ID: <42ac5309-62aa-1c5e-3cbb-cb40d68e8b9b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC team,

Sorry for the late pull request, but this contains only fixes
that were found when I tested linux-next.

Please pull!

Regards,
Sudeep

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/juno-fixes-4.12

for you to fetch changes up to f9936c4abf63106e0bcc3d82098dd1cfc3dc5290:

  arm64: dts: juno: add information about L1 and L2 caches (2017-04-19
12:16:51 +0100)

----------------------------------------------------------------
ARMv8 Juno DT fixes for v4.12

1. Couple of fixes to remove device tree warnings introduced with
   recently added checks in DTC

2. Add information about L1 and L2 caches to Juno device trees as
   CCSIDR-based cacheinfo probing is now removed

----------------------------------------------------------------
Rob Herring (1):
      arm64: dts: juno: fix PCI bus dtc warnings

Sudeep Holla (2):
      arm64: dts: juno: fix few unit address format warnings
      arm64: dts: juno: add information about L1 and L2 caches

 arch/arm64/boot/dts/arm/juno-base.dtsi        |  4 +--
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 12 +++---
 arch/arm64/boot/dts/arm/juno-r1.dts           | 42 +++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r2.dts           | 42 +++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts              | 42 +++++++++++++++++
 5 files changed, 134 insertions(+), 8 deletions(-)
