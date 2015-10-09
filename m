From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 9 Oct 2015 15:21:00 +0100
Subject: [GIT PULL][2/2] SCPI support on ARM64 Juno Development Platform
In-Reply-To: <20151009141744.GC28928@e103737-lin.cambridge.arm.com>
Message-ID: <20151009142100.GD28928@e103737-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please consider pulling the following commits for v4.4.

Regards,
Sudeep

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-scpi-for-v4.4

for you to fetch changes up to dfacaf0e7cbe9f845459f3332f94cdbc368932af:

  arm64: dts: Add sensor node to Juno dt (2015-10-09 10:26:41 +0100)

----------------------------------------------------------------
SCPI support on ARM64 Juno Development Platform

  1. SRAM, MHU mailbox and SCPI support
  2. CPU topology using cpu-map
  3. Clock support for all the cpus
  4. Support for SoC sensors

----------------------------------------------------------------
Punit Agrawal (1):
      arm64: dts: Add sensor node to Juno dt

Sudeep Holla (3):
      arm64: dts: add SRAM, MHU mailbox and SCPI support on Juno
      arm64: dts: add CPU topology on Juno
      arm64: dts: add clock support for all the cpus

 arch/arm64/boot/dts/arm/juno-base.dtsi | 59 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    | 32 ++++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts       | 32 ++++++++++++++++++
 3 files changed, 123 insertions(+)
