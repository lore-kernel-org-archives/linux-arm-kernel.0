From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 11 Oct 2013 00:44:52 +0530
Subject: [PATCH 0/2] ARM: dts: AM4372: Add more nodes
Message-ID: <1381432494-20498-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add nodes for l2-cache-controller, EDMA, mailbox, mmc, sham,
and updates the properties for cpsw, i2c0, matrix-keypad. 

These patches are applied on top of Benoit's for_3.13/dts branch
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts

Testing:
Tested EDMA, mmc, sham, aes, des, i2c0, cpsw, matric-keypad on AM4372 EPOS EVM
with the addition of following two series:
-> Tero's V8 of OMAP DT clock conversion
  http://www.mail-archive.com/linux-omap at vger.kernel.org/msg96769.html
-> Afzal's V5 of AM43x PRCM basic support
  http://www.mail-archive.com/linux-omap at vger.kernel.org/msg96275.html

Lokesh Vutla (1):
  ARM: dts: AM4372: Add more nodes

Mugunthan V N (1):
  ARM: dts: AM4372: Update Support for EPOS EVM

 arch/arm/boot/dts/am4372.dtsi        |  210 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am43x-epos-evm.dts |  168 +++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/am43xx.h |   31 +++++
 3 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/pinctrl/am43xx.h

-- 
1.7.9.5
