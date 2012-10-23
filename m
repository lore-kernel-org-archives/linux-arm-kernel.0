From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Tue, 23 Oct 2012 10:37:08 +0200
Subject: [PATCH v2 0/4] ARM: dts: Update OMAP5 with address space and
 interrupts
Message-ID: <1350981432-6750-1-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since kernel 3.7 the DTS data are not overwriten by hwmod data we can add the address space
and interrupt line description inside dtsi file for OMAP5. This serie is updating the
current OMAP5 IP with missing entry.

It has been tested on OMAP5 with 3.7-audio-display feature tree.
- MMC is probing and functional
- TWL6041 probing (GPIO/I2C)
- booting (UART)

Update since v1:
- Add Ack and review
- Fix up commit messages.

Sebastien Guiriec (4):
  ARM: dts: omap5: Update GPIO with address space and interrupts
  ARM: dts: omap5: Update I2C with address space and interrupts
  ARM: dts: omap5: Update UART with address space and interrupts
  ARM: dts: omap5: Update MMC with address space and interrupts

 arch/arm/boot/dts/omap5.dtsi |   56 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
1.7.10.4
