From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Mar 2017 11:51:47 +0100
Subject: [PATCH v2 0/5] arm: spear6xx: DT cleanups and improvements
Message-ID: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small series brings a few minor DT cleanups and improvements for
the SPEAr600 platform:

 - Provide and use DT node labels
 - Fix minor coding style issue
 - Switch to the new MTD partition DT binding
 - Remove unneeded pinctrl properties

Changes since v1:

 - Add a few more node labels, and convert the spear600-evb.dts to use
   node labels, so that one platform upstream uses the node labels.

 - Add more patches making misc cleanups/improvements in
   spear600-evb.dts.

Thanks!

Thomas

Thomas Petazzoni (5):
  arm: spear6xx: add labels to various nodes in spear600.dtsi
  arm: spear6xx: use node labels in spear600-evb.dts
  arm: spear6xx: fix spaces in spear600-evb.dts
  arm: spear6xx: switch spear600-evb to the new flash partition DT
    binding
  arm: spear6xx: remove unneeded pinctrl properties in spear600-evb

 arch/arm/boot/dts/spear600-evb.dts | 148 ++++++++++++++++++-------------------
 arch/arm/boot/dts/spear600.dtsi    |  20 ++---
 2 files changed, 82 insertions(+), 86 deletions(-)

-- 
2.7.4
