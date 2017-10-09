From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 9 Oct 2017 18:27:38 +0100
Subject: [GIT PULL] arm64: dts: vexpress/juno: update for v4.15
Message-ID: <68191766-e47e-c4a5-a858-dc01620db36f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

--

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/juno-updates-4.15

for you to fetch changes up to bc3d3447b66a9eb398c7cce96f05b7c78d725abc:

  arm64: dts: foundation-v8: Enable PSCI mode (2017-10-03 15:10:17 +0100)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT update for v4.15

Just single update to enable PSCI support on Foundation models

----------------------------------------------------------------
Daniel Thompson (1):
      arm64: dts: foundation-v8: Enable PSCI mode

 arch/arm64/boot/dts/arm/Makefile                   |  4 +++-
 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi   | 19 +++++++++++++++
 .../boot/dts/arm/foundation-v8-gicv3-psci.dts      |  9 +++++++
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts    | 25 ++-----------------
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi   | 28
++++++++++++++++++++++
 arch/arm64/boot/dts/arm/foundation-v8-psci.dts     |  9 +++++++
 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi    | 28
++++++++++++++++++++++
 .../boot/dts/arm/foundation-v8-spin-table.dtsi     | 25 +++++++++++++++++++
 arch/arm64/boot/dts/arm/foundation-v8.dts          | 16 ++-----------
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         | 16 ++++---------
 10 files changed, 129 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-psci.dts
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
