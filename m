From: dev@lynxeye.de (Lucas Stach)
Date: Sat,  8 Apr 2017 16:36:00 +0200
Subject: [RFC PATCH 0/7] Hummingboard2 improvements
Message-ID: <20170408143607.15928-1-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

the following patches are on top your HB2 branch. They mostly change things
that are different/redundant on mainline and allow me to drop my version of
the HB2 DT, as they are mostly aligned now.

Feel free to squash those patches down, when you send out the HB2 DT. You
may also consider this a Tested-by for the patches from Jon and you that
are currently in your HB2 branch.

Regards,
Lucas

Lucas Stach (7):
  ARM: dts: imx6*-hummingboard2: fix formatting
  ARM: dts: imx6*-hummingboard2: add SGTL5000 VDDD supply
  ARM: dts: imx6*-hummingboard2: remove LDB node
  ARM: dts: imx6*-hummingboard2: fix PCIe reset polarity
  ARM: dts: imx6*-hummingboard2: remove non-mainline property from RTC
  ARM: dts: imx6*-hummingboard2: remove redundant PWM disables
  ARM: dts: imx6*-hummingboard2: rework regulators

 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 61 ++++++++++------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

-- 
2.9.3
