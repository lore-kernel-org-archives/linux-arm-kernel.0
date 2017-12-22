From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 22 Dec 2017 11:21:06 +0100
Subject: [GIT PULL] arm: actions: dt64 for v4.16 #1
In-Reply-To: <20171222102107.5661-1-afaerber@suse.de>
References: <20171222102107.5661-1-afaerber@suse.de>
Message-ID: <20171222102107.5661-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's my dt64 pull for Actions Semi.
This adds S700 and the CubieBoard7. Timer binding will go via timer tree.
A second pull will follow after I've converted S900 to new SPDX style.

Regards,
Andreas

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-dt-for-4.16

for you to fetch changes up to 0bea2a65387961efcb59794a9fb7f9a63c6eb722:

  arm64: dts: actions: Add S700 and CubieBoard7 (2017-12-22 10:52:54 +0100)

----------------------------------------------------------------
Actions Semi arm64 based SoC DT for v4.16

This adds S700 SoC and CubieBoard7.

----------------------------------------------------------------
Andreas F?rber (3):
      dt-bindings: arm: actions: Add S700 and CubieBoard7
      dt-bindings: power: Add Actions Semi S700 SPS
      arm64: dts: actions: Add S700 and CubieBoard7

 Documentation/devicetree/bindings/arm/actions.txt  |  15 ++
 .../devicetree/bindings/power/actions,owl-sps.txt  |   2 +
 arch/arm64/boot/dts/actions/Makefile               |   2 +
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |  46 ++++++
 arch/arm64/boot/dts/actions/s700.dtsi              | 169 +++++++++++++++++++++
 include/dt-bindings/power/owl-s700-powergate.h     |  19 +++
 6 files changed, 253 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s700-cubieboard7.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700.dtsi
 create mode 100644 include/dt-bindings/power/owl-s700-powergate.h
