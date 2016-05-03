From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  3 May 2016 23:58:02 +0800
Subject: [GIT PULL 2/6] i.MX device tree updates for 4.7, with new clocks
In-Reply-To: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
References: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1462291086-19925-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc folks,

As per request from Arnd, I collected the device tree updates with new
clock ID dependency on a separate branch imx/dt-clkdep.  The dependant
clock changes has been pulled by clk folks.

Please pull, thanks.

Shawn


The following changes since commit 7b5ca4533f1ac023a16e44a2a1680121272723f9:

  Merge tag 'imx-clk-4.7' into imx/dt-clkdep (2016-04-13 17:36:03 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-clkdep-4.7

for you to fetch changes up to 77f0862d0d6874a73f83032b7ffd6d204fc8646c:

  ARM: dts: vf610-colibri: enable display controller (2016-04-13 17:42:47 +0800)

----------------------------------------------------------------
The i.MX device tree updates with new clocks for 4.7:
 - Add LCDIF and FlexCAN device support for i.MX7D
 - New support i.MX7D based Nitrogen7 board from Boundary Devices
 - Add display support for vf610-colibri board

----------------------------------------------------------------
Gary Bisson (3):
      ARM: dts: imx7d: add lcdif support
      ARM: dts: imx7d: add flexcan support
      ARM: dts: imx: add Boundary Devices Nitrogen7 board

Stefan Agner (2):
      ARM: dts: vf610: add display nodes
      ARM: dts: vf610-colibri: enable display controller

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/imx7d-nitrogen7.dts     | 745 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi              |  31 ++
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |  16 +
 arch/arm/boot/dts/vf-colibri.dtsi         |  33 ++
 arch/arm/boot/dts/vfxxx.dtsi              |  19 +
 6 files changed, 845 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-nitrogen7.dts
