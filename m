From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 14 Aug 2017 12:49:46 +0100
Subject: [PATCH  0/3] Add SDHI Support
Message-ID: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add SDHI support for r8a7743 SoC.

This series has been compiled and tested against renesas-dev tag
renesas-devel-20170814-v4.13-rc5.

There is no compile time dependencies.It has run time dependency on
[PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support.
https://patchwork.kernel.org/patch/9898611/ 

Biju Das (3):
  ARM: dts: r8a7743: Add SDHI controllers
  ARM: dts: iwg20m: Enable SDHI0 controller
  ARM: dts: iwg20d-q7: Add SDHI1 support

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 48 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi   | 17 ++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi          | 42 +++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

-- 
1.9.1
