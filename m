From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 18 Jul 2012 16:07:17 -0600
Subject: [RFC PATCHv5] arm: socfpga: Add initial support for Altera's SOCFPGA
 HW
Message-ID: <1342649238-1044-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

This patch adds minimal support for Altera's SOCFPGA hardware.

Changes since v4:
- Removed common.h

Changes since v3:
- Condensed to 1 patch per Pavel Machek
- Added only root clocks(fixed-rate) definitions in drivers/clk/socfpga
- Update dtsi file per Thomas Petazzoni's recommendation
- Add extern sys_timer dw_apb_timer declaration in include/linux/dw_apb_timer.h

Changes since v2:
- Make use of COMMON_CLK - socfpga folder under drivers/clk
- Add maintainer entry for drivrs/clk/socfpga
- Incorporated changes suggestd by Thomas Petazzoni, Arnd Bergmann,
and Rob Herring
- Added Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Changes since v1:
- Incorporate changes suggested by Pavel Machek, Thommas Petazzoni,
  Arnd Bergmann, and Rob Herring
- Reduce the patch to a make as much use of DTS as possible

Dinh Nguyen (1):
  ARM: socfpga: initial support for Altera's SOCFPGA platform

-- 
1.7.9.5
