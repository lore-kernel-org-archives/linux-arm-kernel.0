From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Thu,  4 Sep 2014 16:02:51 +0300
Subject: [PATCH 0/2] fix cm-t54 serial console power supply
Message-ID: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Essential fix of CM-T54 serial console power supply and
minor update of SBC-T54 DT model property.

Dmitry Lifshitz (2):
  ARM: dts: cm-t54: fix serial console power supply.
  ARM: dts: sbc-t54: fix model property

 arch/arm/boot/dts/omap5-cm-t54.dts  |    5 ++---
 arch/arm/boot/dts/omap5-sbc-t54.dts |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
1.7.5.4
