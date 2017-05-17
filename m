From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 12:45:19 +0800
Subject: [PATCH 0/4] amend some properties related clk and cpu for rk322x
Message-ID: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series of patches amend some assigned-clocks and add cpu opp table
for rk322x SoCs.

the following patches on patchwork are required for this changes.
https://patchwork.kernel.org/patch/9627639/
https://patchwork.kernel.org/patch/9703945/
https://patchwork.kernel.org/patch/9703939/
https://patchwork.kernel.org/patch/9707517/

Elaine Zhang (1):
  arm: dts: rk322x: add some assigned-clocks

Finley Xiao (2):
  arm: dts: rk322x: add operating-points-v2 property for cpu
  arm: dts: rk3229: add a new cpu opp table

Rocky Hao (1):
  arm: dts: rk322x: update tsadc's frequence setting

 arch/arm/boot/dts/rk3229-cpu-opp.dtsi | 85 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi         | 52 ++++++++++++++++++---
 2 files changed, 131 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229-cpu-opp.dtsi

-- 
2.0.0
