From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 09:00:59 -0500
Subject: [PATCH 0/3] pinctrl: Add DRA7/AM437x pinctrl compatibility
Message-ID: <1408716062-26055-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series are various fixes and improvements for pinctrl
for AM437x and DRA7. It also tries to add documentation for existing
pinctrl bindings for Texas Instruments' OMAP SoCs.

Functionality depends on the dts update (in series 6), PRM fixes and
the pdata quirk changes

This is part 4/6 series which eventually enables framework for
suspend-to-ram and cpuidle for OMAP5 and DRA7

Each of series is based on v3.17-rc1 and this specific series is available:
weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/pinctrl-compat

git repo: https://github.com/nmenon/linux-2.6-playground.git push/v3.17/pinctrl-compat

An complete integrated branch is available here: https://github.com/nmenon/linux-2.6-playground/commits/testing/v3.17/cpu-idle-suspend-dra7-omap5-framework

Keerthy (1):
  pinctrl: single: AM437x: Add pinctrl compatibility

Nishanth Menon (2):
  pinctrl: bindings: Add OMAP pinctrl binding
  pinctrl: single: Add DRA7 pinctrl compatibility

 .../bindings/pinctrl/ti,omap-pinctrl.txt           |   11 +++++++++++
 drivers/pinctrl/pinctrl-single.c                   |   14 ++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt

-- 
1.7.9.5
