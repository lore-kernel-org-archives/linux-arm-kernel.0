From: mike.leach@linaro.org (Mike Leach)
Date: Wed, 11 Jan 2017 20:44:07 +0000
Subject: [PATCH v2 0/2] arm64: dts: juno: Updates for juno r1/r2 boards
Message-ID: <1484167449-14432-1-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juno r1/r2 boards have different CoreSight infrastructure outside the
clusters. This patchset moves the none cluster CoreSight to separate
.dtsi files to allow for these differences.

v2 moves the Addition of the STM component into a separate patch.

Mike Leach (2):
  arm64: dts: juno: Fix CoreSight support for Juno r1/r2 variants
  arm64: dts: juno: Adds missing CoreSight STM component.

 arch/arm64/boot/dts/arm/juno-base.dtsi    | 135 ---------------
 arch/arm64/boot/dts/arm/juno-cs-r0.dtsi   | 166 +++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 266 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts       |   1 +
 arch/arm64/boot/dts/arm/juno-r2.dts       |   1 +
 arch/arm64/boot/dts/arm/juno.dts          |   1 +
 6 files changed, 435 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi

-- 
2.7.4
