From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Jul 2012 18:50:54 -0600
Subject: [RFC PATCHv3 0/2] arm: socfpga: Add initial support for Altera's
 SOCFPGA HW
Message-ID: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

This patch series add minimal support for Altera's SOCFPGA hardward.

Changes since v2:
- Make use of COMMON_CLK - socfpga folder under drivers/clk
- Add maintainer entry for drivers/clk/socfpga
- Incorporated changes suggestd by Thomas Petazzoni, Arnd Bergmann,
and Rob Herring
- Added Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Changes since v1:
- Incorporate changes suggested by Pavel Machek, Thommas Petazzoni,
  Arnd Bergmann, and Rob Herring
- Reduce the patch to a make as much use of DTS as possible

Dinh Nguyen (2):
  ARM: socfpga: initial support for Altera's SOCFPGA platform
  ARM: socfpga: Add DTS bindings for Altera's SOCFPGA

-- 
1.7.9.5
